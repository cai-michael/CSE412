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

const listSites = (endpoint, key) =>
  getData(endpoint, key, {
    queryType: 'findAllSiteNames',
    parameters: {},
  })

const listCounties = (endpoint, key) =>
  getData(endpoint, key, {
    queryType: 'findAllCountyNames',
    parameters: {},
  })

const listStates = (endpoint, key) =>
  getData(endpoint, key, {
    queryType: 'findAllStateNames',
    parameters: {},
  })

const listTypes = (endpoint, key) => Promise.resolve([['O3'], ['CO'], ['SO2'], ['NO2']])

const Selector = ({items, setItems}) => {
  const selectItem = (itemName) => (_) =>
    setItems(items.map((item) => ({...item, checked: item.name === itemName})))

  return (
    <form>
      {items &&
        items.map((item) => (
          <Fragment key={item.name}>
            <label>
              <input
                name={item.name}
                type="radio"
                checked={item.checked}
                onChange={selectItem(item.name)}
              />
              {item.name}
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

const makeRequest = (queryType, city, county, state, pollutant) => {
  if (queryType === 'pollutantBySiteAndType') {
    return {queryType, parameters: {city, pollutant}}
  } else if (queryType === 'pollutantByCountyAndType') {
    return {queryType, parameters: {county, pollutant}}
  } else if (queryType === 'pollutantByStateAndType') {
    return {queryType, parameters: {state, pollutant}}
  }
}

export default () => {
  const [sites, setSites] = useState([])
  const [counties, setCounties] = useState([])
  const [states, setStates] = useState([])
  const [types, setTypes] = useState([])
  const [queries, setQueries] = useState([
    {name: 'Site and Type', queryType: 'pollutantBySiteAndType', checked: true},
    {name: 'County and Type', queryType: 'pollutantByCountyAndType', checked: false},
    {name: 'State and Type', queryType: 'pollutantByStateAndType', checked: false},
  ])
  const [data, setData] = useState([])

  const ENDPOINT = process.env.REACT_APP_ENDPOINT
  const API_KEY = process.env.REACT_APP_API_KEY

  const addCheckboxes = (l) => l.map((r, i) => ({name: r[0], checked: i === 0}))

  useEffect(() => {
    const effect = async () => {
      setSites(addCheckboxes(await listSites(ENDPOINT, API_KEY)))
      setCounties(addCheckboxes(await listCounties(ENDPOINT, API_KEY)))
      setStates(addCheckboxes(await listStates(ENDPOINT, API_KEY)))
      setTypes(addCheckboxes(await listTypes(ENDPOINT, API_KEY)))
    }
    effect()
  }, [ENDPOINT, API_KEY])

  const selected = (items) => items?.filter((i) => i?.checked)[0]

  useEffect(() => {
    const effect = async () => {
      const body = makeRequest(
        selected(queries)?.queryType,
        selected(sites)?.name,
        selected(counties)?.name,
        selected(states)?.name,
        selected(types)?.name,
      )

      const isReady =
        0 ===
        Object.values(body.parameters).filter((i) => i === null || i === undefined)
          .length

      if (isReady) {
        const results = await getData(ENDPOINT, API_KEY, body)
        const normalized = results.map((d) => {
          if (d.length === 3) return [new Date(d[0]), d[1], d[2], colorPollutant(d[1])]
          else return [new Date(d[0]), d[2], d[3], colorPollutant(d[2])]
        })
        setData(normalized)
      }
    }
    effect()
  }, [queries, sites, counties, states, types, ENDPOINT, API_KEY])

  return (
    <>
      <h1>Air Quality Data Visualization Tool</h1>
      <h2>Michael Cai, Jacob Farabee, Kesav Kadalazhi, Madison Kuhler, Brennan Kuhman, Jack Summers</h2>
      <div class="toolbar">
      <div class="row">
        
          <div class="column">
          <h3>Query Type</h3>
          <Selector items={queries} setItems={setQueries} />
            <br />
            
          </div>

          <div class="column">
            
            {selected(queries).queryType === 'pollutantBySiteAndType' && (
                <>
                  <h3>Site</h3>
                  <Selector items={sites} setItems={setSites} />
                  <br />
                </>
              )}

            {selected(queries).queryType === 'pollutantByCountyAndType' && (
              <>
                <h3>County</h3>
                <Selector items={counties} setItems={setCounties} />
                <br />
              </>
            )}

            {selected(queries).queryType === 'pollutantByStateAndType' && (
              <>
                <h3>State</h3>
                <Selector items={states} setItems={setStates} />
                <br />
              </>
            )}

          </div>
          <div class="column">
            <h3>Pollutant Type</h3>
            <Selector items={types} setItems={setTypes} />
            <br />
          </div>
      </div>
      </div>

      

      <div class="graph">
        <ScatterPlot data={data} />
      </div>
      
    </>
  )
}
