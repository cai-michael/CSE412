import React, {Fragment, useState, useEffect} from 'react'
import ScatterPlot from './ScatterPlot'
import './App.css'

const getData = (endpoint, key, body) => {
  return fetch(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': key,
    },
    body: JSON.stringify(body),
  }).then((r) => r.json())
}

const StateSelector = ({states, setStates}) => {
  const selectState = (stateName) => (_) =>
    setStates(states.map((state) => ({...state, checked: state.name === stateName})))

  return (
    <form>
      {states.map((state) => (
        <Fragment key={state.name}>
          <label>
            <input
              name={state.name}
              type="radio"
              checked={state.checked}
              onChange={selectState(state.name)}
            />
            {state.name}
          </label>
          <br />
        </Fragment>
      ))}
    </form>
  )
}

const PollutantSelector = ({pollutants, setPollutants}) => {
  const selectPollutant = (pollutantName) => (_) =>
    setPollutants(
      pollutants.map((p) => {
        if (pollutantName === p.name) return {...p, checked: !p.checked}
        else return p
      }),
    )

  return (
    <form>
      {pollutants.map((pollutant) => (
        <Fragment key={pollutant.name}>
          <label>
            <input
              name={pollutant.name}
              type="checkbox"
              checked={pollutant.checked}
              onChange={selectPollutant(pollutant.name)}
            />
            {pollutant.name}
          </label>
          <br />
        </Fragment>
      ))}
    </form>
  )
}

const colorPollutant = (pollutant) => {
  if (pollutant === 'O3') return 'orange'
  else if (pollutant === 'CO') return 'blue'
  else if (pollutant === 'SO2') return 'red'
  else if (pollutant === 'NO2') return 'brown'
  else return 'black'
}

export default () => {
  const [states, setStates] = useState([
    {name: 'Arizona', checked: true},
    {name: 'California', checked: false},
  ])
  const [pollutants, setPollutants] = useState([
    {name: 'O3', checked: true},
    {name: 'CO', checked: false},
    {name: 'SO2', checked: false},
    {name: 'NO2', checked: false},
  ])

  const [data, setData] = useState([])

  const ENDPOINT = process.env.REACT_APP_ENDPOINT
  const API_KEY = process.env.REACT_APP_API_KEY

  useEffect(() => {
    const effect = async () => {
      const selectedState = states.filter((state) => state.checked)[0]
      const selectedPollutants = pollutants.filter((p) => p.checked).map((p) => p.name)

      if (selectedState && selectedPollutants.length !== 0) {
        const body = {
          queryType: 'pollutantByState',
          parameters: {state: selectedState.name},
        }
        const results = await getData(ENDPOINT, API_KEY, body)
        setData(
          results
            .filter((d) => selectedPollutants.includes(d[1]))
            .map((d) => [new Date(d[0]), d[1], d[2], colorPollutant(d[1])]),
        )
      }

      // TODO: investigate alternate query types
      // const body = {queryType: 'pollutantBySite', parameters: {city: 'San Jose'}}
      // const body = {queryType: 'testRestAPI', parameters: {pollutant: 'NO2'}}
      // const body = {
      //   queryType: 'siteMeansForSpecifiedPollutant',
      //   parameters: {pollutant: 'NO2'},
      // }
    }
    effect()
  }, [states, pollutants, ENDPOINT, API_KEY])

  return (
    <>
      <div class="heading">
        <h1>Pollutant Data Visualization</h1>
        <h2>Michael Cai, Jacob Farabee, Kesav Kadalazhi, Madison Kuhler, Brennan Kuhman, Jack Summers</h2>
      </div>
      <div class="toolbar">

        <div class="row">
          <div class="column">
            <h4>State</h4>
            <StateSelector {...{states, setStates}} />
          </div>
          
          <div class="column">
            <h4>Pollutant</h4>
            <PollutantSelector {...{pollutants, setPollutants}} />
          </div>

        </div>
      </div>
      

      <div class="graph">
        <ScatterPlot {...{data}} />
      </div>
      
      
    </>
  )
}
