// convert-pem-to-jwk.mjs
import fs from 'fs/promises';
import { importSPKI } from 'jose/key/import';
import { exportJWK } from 'jose/key/export';

const pem = await fs.readFile('docker/development-easy/certs/jwks/public_key.pem', 'utf8');
const key = await importSPKI(pem, 'RS256');
const jwk = await exportJWK(key);

jwk.use = 'sig'; // optional, but useful for clarity
jwk.kid = 'my-rsa-key'; // optional, useful for identifying the key

console.log(JSON.stringify({ keys: [jwk] }, null, 2));
