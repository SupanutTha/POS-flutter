const uuid = require('uuid');

const validApiKeys = ['c65f213d-c776-4781-8fda-26b3be0b22b8', '5034df56-7c10-4303-8a4a-84b29016c203']; // Replace with your generated API keys

const apiKeyMiddleware = (req, res, next) => {
  const apiKey = req.headers['x-api-key'];

  if (!apiKey || !validApiKeys.includes(apiKey)) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  // If the API key is valid, proceed to the next middleware or route handler
  next();
};

module.exports = apiKeyMiddleware;

// Generated API Key 1: c65f213d-c776-4781-8fda-26b3be0b22b8
// Generated API Key 2: 5034df56-7c10-4303-8a4a-84b29016c203