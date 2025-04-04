// If using Node 18+, you can use built-in fetch. Otherwise: import fetch from 'node-fetch';
import fs from 'fs/promises';

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

// 🛠️ Replace these with your actual values:
const OPENEMR_REGISTRATION_URL = 'https://localhost:9300/oauth2/default/registration';
const JWKS_PATH = 'docker/development-easy/certs/jwks/jwks.json'; // JWKS must contain {"keys": [ ... ] }

const main = async () => {
  try {
    const jwksRaw = await fs.readFile(JWKS_PATH, 'utf8');
    const jwks = JSON.parse(jwksRaw);

    const registrationPayload = {
      application_type: 'private',
      client_name: 'My API Client App',
      redirect_uris: ['https://myapp.local/callback'],
      post_logout_redirect_uris: ['https://myapp.local/logout'],
      token_endpoint_auth_method: 'private_key_jwt',
      scope: 'system/Patient.read api:oemr api:fhir',
      jwks: jwks
    };

    const response = await fetch(OPENEMR_REGISTRATION_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(registrationPayload)
    });

    const text = await response.text();
    if (!response.ok) {
      console.error(`❌ Registration failed: ${response.status} ${response.statusText}`);
      console.error('Response body:', text);
      return;
    }

    const responseBody = await response.json();
    console.log('✅ Registration successful!');
    console.log(JSON.stringify(responseBody, null, 2));
  } catch (err) {
    console.error('❌ Error during registration:', err);
  }
};

main();
