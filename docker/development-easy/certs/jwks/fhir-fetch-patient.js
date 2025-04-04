const jwt = require('jsonwebtoken');
const uuid = require('uuid');
const fs = require('fs');
const { createHash } = require('crypto');

// Disable TLS verification for local testing (not recommended for production)
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

// Configuration
const registrationRaw = fs.readFileSync('docker/development-easy/certs/jwks/registration.json', 'utf8');
const registration = JSON.parse(registrationRaw);
const client_id = registration.client_id;
const token_url = "https://localhost:9300/oauth2/default/token";
const fhir_base_url = "https://localhost:9300/apis/default/fhir";
const private_key_path = "docker/development-easy/certs/jwks/private_key.pem";
const jwks_path = "docker/development-easy/certs/jwks/jwks.json";

// Step 1: Load the private key and JWKS to compute the kid
const private_key = fs.readFileSync(private_key_path, 'utf8');
const jwksRaw = fs.readFileSync(jwks_path, 'utf8');
const jwks = JSON.parse(jwksRaw);
const jwk = jwks.keys[0];
const jwkString = JSON.stringify(jwk);
const kid = createHash('sha256').update(jwkString).digest('base64url');

// Step 2: Generate the JWT for client authentication
const payload = {
    iss: client_id,
    sub: client_id,
    aud: token_url,
    jti: uuid.v4(),
    exp: Math.floor(Date.now() / 1000) + 600, // 10 minutes from now
    iat: Math.floor(Date.now() / 1000)
};

const jwt_token = jwt.sign(payload, private_key, {
    algorithm: 'RS384', // Matches your Postman request
    header: { kid: kid }
});

// Step 3: Request an access token from the OAuth2 token endpoint
const tokenRequestBody = new URLSearchParams({
    grant_type: 'client_credentials',
    scope: 'openid offline_access api:oemr api:fhir api:port patient/Patient.read system/Patient.read',
    client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
    client_assertion: jwt_token
});

async function getAccessToken() {
    try {
        const response = await fetch(token_url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: tokenRequestBody.toString()
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Token request failed: ${response.status} ${response.statusText}\n${errorText}`);
        }

        const tokenData = await response.json();
        console.log('Access Token Response:', JSON.stringify(tokenData, null, 2));
        return tokenData.access_token;
    } catch (error) {
        console.error('Error getting access token:', error.message);
        throw error;
    }
}

// Step 4: Use the access token to fetch patient data from the FHIR API
async function fetchPatients(access_token) {
    try {
        const url = `${fhir_base_url}/Patient`;
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${access_token}`,
                'Accept': 'application/fhir+json'
            }
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`FHIR request failed: ${response.status} ${response.statusText}\n${errorText}`);
        }

        const patientData = await response.json();
        console.log('Patient Data:', JSON.stringify(patientData, null, 2));
        return patientData;
    } catch (error) {
        console.error('Error fetching patients:', error.message);
        throw error;
    }
}

// Main function to orchestrate the process
async function main() {
    try {
        // Get the access token
        const access_token = await getAccessToken();

        // Fetch patient data
        await fetchPatients(access_token);
    } catch (error) {
        console.error('Script failed:', error.message);
    }
}

// Run the script
main();