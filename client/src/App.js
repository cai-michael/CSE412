import React from 'react';
import logo from './logo.svg';
import './App.css';
const axios = require('axios');

const ENDPOINT = process.env.REACT_APP_ENDPOINT;
const API_KEY = process.env.REACT_APP_API_KEY;

// This sends the POST request to AWS Lambda
async function testRestAPI(endpoint, key, body) {
  try {
    const result = await axios.post(endpoint, body, {
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': key
      }
    });
    return result.data;
  } catch (err) {
    console.log(err);
    return null;
  }
}

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

const body = {
  "queryType": "pollutantByState",
  "parameters": {
    "state": "Arizona"
  }
};

const result = testRestAPI(ENDPOINT, API_KEY, body)
console.log(result)

export default App;
