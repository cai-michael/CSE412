import React, {useRef, useEffect} from 'react'
import {select, scaleLinear, max, axisBottom, axisLeft} from 'd3'
import './BarChart.css'

const getColor = (pollutant) => {
  if (pollutant === 'CO') return 'yellow'
  else if (pollutant === 'NO2') return 'red'
  else if (pollutant === 'O3') return 'blue'
  else if (pollutant === 'SO2') return 'orange'
  else return 'black'
}

export default ({data}) => {
  const container = useRef(null)

  useEffect(() => {
    if (data.length === 0) return

    const width = 1335
    const height = 975
    const padding = 30

    const svg = select(container.current)
    svg.attr('width', width).attr('height', height)

    const xScale = scaleLinear()
      .domain([0, data.length])
      .range([padding, width - padding])

    const yScale = scaleLinear()
      .domain([0, max(data.map((d) => d[2]))])
      .range([height - padding, padding])

    const circles = svg.selectAll('circle').data(data).enter().append('circle')
    circles
      .attr('fill', (d) => getColor(d[1]))
      .attr('cx', (d, i) => xScale(i))
      .attr('cy', (d) => yScale(d[2]))
      .attr('r', 3)

    const xAxis = axisBottom().scale(xScale)
    svg
      .append('g')
      .attr('class', 'axis')
      .attr('transform', `translate(0, ${height - padding})`)
      .call(xAxis)

    const yAxis = axisLeft().scale(yScale)
    svg
      .append('g')
      .attr('class', 'axis')
      .attr('transform', `translate(${padding}, 0)`)
      .call(yAxis)
  }, [data])

  return <svg ref={container}></svg>
}
