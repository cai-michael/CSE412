--Returns all samples for a state within the given timeframe
--The data is ordered by date_local which is useful for creating a linegraph
--Inputs (user_provided_state_code, provided_lower_date_limit, provided_upper_date_limit)
SELECT p_s.date_local, p_s.id, p_s.mean
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id == t_a.sample_id
INNER JOIN in_state
	ON t_a.site_num == in_state.site_num
WHERE in_state.state_code == user_provided_state_code
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY date_local

--Returns all samples for a state
--The data is ordered by date_local which is useful for creating a linegraph
--Inputs (user_provided_state_code)
SELECT p_s.date_local, p_s.id, p_s.mean
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id == t_a.sample_id
INNER JOIN in_state
	ON t_a.site_num == in_state.site_num
WHERE in_state.state_code == user_provided_state_code
ORDER BY date_local