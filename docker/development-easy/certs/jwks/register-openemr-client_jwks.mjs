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

    //  patient/Procedure.read system/Patient.read system/AllergyIntolerance.read system/CarePlan.read system/CareTeam.read system/Condition.read system/Coverage.read system/Device.read system/DiagnosticReport.read system/Document.read system/DocumentReference.read system/Encounter.read system/Goal.read system/Group.read system/Immunization.read system/Location.read system/Medication.read system/MedicationRequest.read system/Observation.read system/Organization.read system/Person.read system/Practitioner.read system/PractitionerRole.read system/Procedure.read system/Provenance.read
    const registrationPayload = {
      "application_type": "private",
      "redirect_uris": ["https://localhost:8080/redirect"],
      "post_logout_redirect_uris": ["https://localhost:8080/logout"],
      "client_name": "JWT App 101",
      "initiate_login_url": "https://localhost:8081/launch",
      "token_endpoint_auth_method": "client_secret_post",
      "contacts": [ "me@example.org","them@example.org"],
      "scope": "openid offline_access api:oemr api:fhir api:port patient/Patient.read system/Patient.read",
     "jwks": jwks,
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

    console.log('✅ Registration successful!');
    console.log(JSON.stringify(text, null, 2));
    // write to ./registration.json
    await fs.writeFile('docker/development-easy/certs/jwks/registration.json', text, 'utf8');
  } catch (err) {
    console.error('❌ Error during registration:', err);
  }
};

main();
