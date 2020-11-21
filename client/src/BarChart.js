import React, {useRef, useEffect} from 'react'
import {
  select,
  scaleLinear,
  scaleTime,
  min,
  max,
  axisBottom,
  axisLeft,
  timeWeek,
} from 'd3'
import './BarChart.css'

const getColor = (pollutant) => {
  if (pollutant === 'O3') return 'orange'
  else if (pollutant === 'CO') return 'blue'
  else if (pollutant === 'SO2') return 'red'
  else if (pollutant === 'NO2') return 'brown'
  else return 'black'
}

export default ({data}) => {
  const container = useRef(null)

  useEffect(() => {
    const width = 1335
    const height = 800
    const padding = 30

    const svg = select(container.current)
    svg.attr('width', width).attr('height', height)

    const dates = data.map((d) => d[0])
    const xScale = scaleTime()
      .domain([min(dates), max(dates)])
      .range([padding, width - padding])

    const yScale = scaleLinear()
      .domain([0, max(data.map((d) => d[2]))])
      .range([height - padding, padding])

    const circles = svg.selectAll('circle').data(data)

    circles
      .attr('fill', (d) => getColor(d[1]))
      .transition()
      .attr('cx', (d) => xScale(d[0]))
      .attr('cy', (d) => yScale(d[2]))
      .attr('r', 3)

    circles
      .enter()
      .append('circle')
      .attr('fill', (d) => getColor(d[1]))
      .transition()
      .attr('cx', (d) => xScale(d[0]))
      .attr('cy', (d) => yScale(d[2]))
      .attr('r', 3)

    circles.exit().transition().duration(5).remove()

    const xAxis = axisBottom().scale(xScale).ticks(timeWeek.every(1))
    svg
      .select('g#axisBottom')
      .transition()
      .attr('class', 'axis')
      .attr('transform', `translate(0, ${height - padding})`)
      .call(xAxis)

    const yAxis = axisLeft().scale(yScale)
    svg
      .select('g#axisLeft')
      .transition()
      .attr('class', 'axis')
      .attr('transform', `translate(${padding}, 0)`)
      .call(yAxis)
  }, [data])

  return (
    <svg ref={container}>
      <g id="axisBottom"></g>
      <g id="axisLeft"></g>
    </svg>
  )
}
