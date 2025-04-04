import fs from 'fs/promises';

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'; // Only for development; remove in production!

// Replace with your actual values
const OPENEMR_REGISTRATION_URL = 'https://localhost:9300/oauth2/default/registration';

const main = async () => {
  try {
    const registrationPayload = {
      client_name: 'My API Client App',
      token_endpoint_auth_method: 'client_secret_basic',
      scope: 'system/Patient.read api:oemr api:fhir'
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

    const responseBody = JSON.parse(text);
    console.log('✅ Registration successful!');
    console.log(JSON.stringify(responseBody, null, 2));
  } catch (err) {
    console.error('❌ Error during registration:', err);
  }
};

main();