const jwt = require('jsonwebtoken');
const uuid = require('uuid');
const fs = require('fs');
const { createHash } = require('crypto');

// Configuration
//const client_id = "3Nh0i-ovYB06S4KMnxRGUyuja8rvheXi4gSIKyHwf-c";
// read the client_id from the file registration.json
const registrationRaw = fs.readFileSync('docker/development-easy/certs/jwks/registration.json', 'utf8');
const registration = JSON.parse(registrationRaw);
const client_id = registration.client_id; // Use the client_id from the registration response
const token_url = "https://localhost:9300/oauth2/default/token";

// Read the private key
const private_key = fs.readFileSync('docker/development-easy/certs/jwks/private_key.pem', 'utf8');

// Compute the kid (same as in JWKS generation)
const jwksRaw = fs.readFileSync('docker/development-easy/certs/jwks/jwks.json', 'utf8'); // Use sync since we're not in an async function
const jwks = JSON.parse(jwksRaw);
const jwk = jwks.keys[0];
const jwkString = JSON.stringify(jwk);
const kid = createHash('sha256').update(jwkString).digest('base64url');

// JWT payload
const payload = {
    iss: client_id,
    sub: client_id,
    aud: token_url,
    jti: uuid.v4(),
    exp: Math.floor(Date.now() / 1000) + 600  // 10 minutes from now
};

// Sign the JWT with RS384
const jwt_token = jwt.sign(payload, private_key, {
    algorithm: 'RS384',
    header: { kid: kid } // Use 'kid' instead of 'hash'
});

console.log(jwt_token);