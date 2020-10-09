--Returns all samples for a state within the given timeframe
--The data is ordered by DateLocal which is useful for creating a linegraph
--Inputs (user_provided_state_code, provided_lower_date_limit, provided_upper_date_limit)
SELECT DateLocal, p_s.id, units
FROM pollutant_sample AS p_s, taken_at AS t_a, in_state
INNER JOIN
	ON p_s.sample_id == t_a.sample_id
INNER JOIN
	ON t_a.site_num == in_state.site_num
WHERE in_state.state_code == user_provided_state_code
	AND DateLocal >= provided_lower_date_limit
	AND DateLocal <= provided_upper_date_limit
ORDER BY DateLocal

--Returns all samples for a state
--The data is ordered by DateLocal which is useful for creating a linegraph
--Inputs (user_provided_state_code)
SELECT p_s.DateLocal, p_s.id, p_s.units
FROM pollutant_sample AS p_s, taken_at AS t_a, in_state	
INNER JOIN
	ON p_s.sample_id == t_a.sample_id
INNER JOIN
	ON t_a.site_num == in_state.site_num
WHERE in_state.state_code == user_provided_state_code
ORDER BY DateLocal
