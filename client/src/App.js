import React from 'react';
import logo from './logo.svg';
import './App.css';

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

export default App;
