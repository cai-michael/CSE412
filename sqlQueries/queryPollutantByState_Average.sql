--Returns the average of the means of the pollutants across all sites in a state, for each date within a given timeframe.
--The data is ordered by date_local which is useful for creating a linegraph
--Inputs (user_provided_state_code, provided_lower_date_limit, provided_upper_date_limit)
SELECT psample.date_local, psample.id, ptype.name, AVG(psample.mean)
FROM pollutant_sample AS psample
	INNER JOIN taken_at AS ta
		ON psample.sample_id = ta.sample_id
	INNER JOIN in_state
		ON ta.site_num = in_state.site_num
	INNER JOIN is_type AS it
		ON psample.id = it.sample_id
	INNER JOIN pollutant_type AS ptype
		ON ptype.id = it.type_id
WHERE in_state.state_code = user_provided_state_code
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
GROUP BY date_local, ptype.name
ORDER BY ptype.name, date_local;

--Returns the average of the means of the pollutants across all sites in a state, for each date.
--The data is ordered by date_local and pollutant name which is useful for creating a linegraph
--Inputs (user_provided_state_code)
SELECT psample.date_local, psample.id, ptype.name, AVG(psample.mean)
FROM pollutant_sample AS psample
	INNER JOIN taken_at AS ta
		ON psample.sample_id = ta.sample_id
	INNER JOIN in_state
		ON ta.site_num = in_state.site_num
	INNER JOIN is_type AS it
		ON psample.id = it.sample_id
	INNER JOIN pollutant_type AS ptype
		ON ptype.id = it.type_id
WHERE in_state.state_code = user_provided_state_code
GROUP BY date_local, ptype.name
ORDER BY ptype.name, date_local;