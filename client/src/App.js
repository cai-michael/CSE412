import React, {useState, useEffect} from 'react'
import BarChart from './BarChart'
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

export default () => {
  const [data, setData] = useState([])

  useEffect(() => {
    const effect = async () => {
      const ENDPOINT = process.env.REACT_APP_ENDPOINT
      const API_KEY = process.env.REACT_APP_API_KEY
      const body = {queryType: 'pollutantByState', parameters: {state: 'Arizona'}}
      setData(await getData(ENDPOINT, API_KEY, body))
    }
    effect()
  }, [])

  return <BarChart data={data} />
}
