--Returns all samples for a state within the given timeframe
--The data is ordered by date_local which is useful for creating a linegraph
--Inputs (user_provided_state_code, provided_lower_date_limit, provided_upper_date_limit)
SELECT psample.date_local, psample.id, psample.mean
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN in_state
	ON ta.site_num = in_state.site_num
WHERE in_state.state_code = user_provided_state_code
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY date_local

--Returns all samples for a state
--The data is ordered by date_local which is useful for creating a linegraph
--Inputs (user_provided_state_code)
SELECT psample.date_local, psample.id, psample.mean
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN in_state
	ON ta.site_num = in_state.site_num
WHERE in_state.state_code = user_provided_state_code
ORDER BY date_local