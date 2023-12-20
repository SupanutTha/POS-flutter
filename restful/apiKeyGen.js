const uuid = require('uuid');

// Generate a unique API key using UUID
function generateApiKey() {
  return uuid.v4();
}

// Example: Generate two API keys
const apiKey1 = generateApiKey();
const apiKey2 = generateApiKey();

console.log('Generated API Key 1:', apiKey1);
console.log('Generated API Key 2:', apiKey2);

// Generated API Key 1: c65f213d-c776-4781-8fda-26b3be0b22b8
// Generated API Key 2: 5034df56-7c10-4303-8a4a-84b29016c203