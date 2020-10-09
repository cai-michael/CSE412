--Returns all samples for a particular pollutant within the given timeframe and their site numbers
--The data is ordered by state and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT p_s.date_local, p_s.name, p_s.mean, t_a.site_num 
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id == t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id == p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
WHERE p_t.name == user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY in_state.state_code, p_s.date_local

--Returns all samples for a particular pollutant and their site numbers
--The data is ordered by state and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT p_s.date_local, p_s.name, p_s.mean, t_a.site_num 
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id == t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id == p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
WHERE p_t.name == user_provided_pollutant_name
ORDER BY in_state.state_code, p_s.date_local

-- Need to create more variations to provide state/county data for different kinds of line graphs