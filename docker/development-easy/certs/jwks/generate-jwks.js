import fs from 'fs/promises';
import { importSPKI } from 'jose/key/import';
import { exportJWK } from 'jose/key/export';
import { createHash } from 'crypto';

const pem = await fs.readFile('docker/development-easy/certs/jwks/public_key.pem', 'utf8');
const key = await importSPKI(pem, 'RS384'); // Use RS384
const jwk = await exportJWK(key);

jwk.use = 'sig'; // Key use: signature

// Compute the kid as SHA-256 hash of the JWK
const jwkString = JSON.stringify(jwk);
const hash = createHash('sha256').update(jwkString).digest('base64url');
jwk.kid = hash;

console.log(JSON.stringify({ keys: [jwk] }, null, 2));

// Save the JWKS to a file for registration
await fs.writeFile('docker/development-easy/certs/jwks/jwks.json', JSON.stringify({ keys: [jwk] }, null, 2));