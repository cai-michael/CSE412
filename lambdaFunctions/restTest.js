const fs = require('fs')
const axios = require('axios');

// This sends the POST request to AWS Lambda
async function testRestAPI(configuration, body) {
  try {
    const result = await axios.post(configuration.endpoint, body, {
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': configuration.apikey
      }
    });
    return result.data;
  } catch (err) {
    console.log(err);
    return null;
  }
}

// This reads the file
function readConfigFile() {
  let jsonString;
  try {
    jsonString = fs.readFileSync('../config.json', 'utf8');
  } catch (err) {
    console.log(`Error reading config from disk: ${err}`);
    return;
  }
  try {
    const config = JSON.parse(jsonString);
    console.log("Read configuration file");
    return config;
  } catch (err) {
    console.log(`Error parsing JSON string: ${err}`);
    return;
  }
}

// This is the part to edit 
async function main() {
  const body = {
    "queryType": "pollutantByState",
    "parameters": {
      "state": "Arizona"
    }
  };
  const config = readConfigFile();
  const result = await testRestAPI(config.lambda, body)
  console.log(result)
}

main().then(() => { console.log('Application Finished') })