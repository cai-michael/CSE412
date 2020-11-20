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
  //const [params, showGraph] = useState(0);
  const dropdown_data = ["a", "b", "c"];

  return (
    <div className="App">
      <header>
        <h1>CSE 412 - Air Pollutant Data</h1>
        <p>Madison Kuhler, Michael Cai, Brennan Kuhman, Jack Summers, Jacob Farabee, Kesav Kadalazhi</p>
      </header>

      <div className="App-body">
        <div className="Get-data">
          {dropdown_data}
          
          <form>
            <select>
              {dropdown_data.map((x) => <option key={x}>{x}</option>)}
            </select>
            <input type="submit" value="View"  />
          </form>

        </div> {/* END GET-DATA */}
      </div> {/* END APP-BODY */}
    </div> 
  );
}

const body = {
  "queryType": "pollutantByState",
  "parameters": {
    "state": "Arizona"
  }
};

let result;
testRestAPI(ENDPOINT, API_KEY, body).then(res => {result = res; console.log(result)})

export default App;
