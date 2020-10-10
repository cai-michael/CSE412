----No differentiation -----------------
--Returns all samples for a particular pollutant within the given timeframe and their site numbers
--The data is ordered by date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT p_s.date_local, p_s.name, p_s.mean, t_a.site_num 
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id = t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id = p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
WHERE p_t.name = user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY p_s.date_local

--Returns all samples for a particular pollutant and their site numbers
--The data is ordered by date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT p_s.date_local, p_s.name, p_s.mean, t_a.site_num 
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id = t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id = p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
WHERE p_t.name = user_provided_pollutant_name
ORDER BY p_s.date_local

----Add State Information---------------------
--Returns all samples for a particular pollutant within the given timeframe and their state
--The data is ordered by state and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT p_s.date_local, p_s.name, p_s.mean, state.state_name 
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id = t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id = p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_state
    ON t_a.site_num = in_state.site_num
INNER JOIN state
    ON state.state_code = in_state.state_code
WHERE p_t.name = user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY state.state_name, p_s.date_local

--Returns all samples for a particular pollutant and their state
--The data is ordered by state and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT p_s.date_local, p_s.name, p_s.mean, state.state_name 
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id = t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id = p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_state
    ON t_a.site_num = in_state.site_num
INNER JOIN state
    ON state.state_code = in_state.state_code
WHERE p_t.name = user_provided_pollutant_name
ORDER BY state.state_name, p_s.date_local

----Add County Information--------------------
--Returns all samples for a particular pollutant within the given timeframe and their county
--The data is ordered by county and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT p_s.date_local, p_s.name, p_s.mean, county.county_name
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id = t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id = p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_county
    ON t_a.site_num = in_county.site_num
INNER JOIN county
    ON county.county_code = in_county.county_code
WHERE p_t.name = user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY county.county_name, p_s.date_local

--Returns all samples for a particular pollutant and their county
--The data is ordered by county and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT p_s.date_local, p_s.name, p_s.mean, county.county_name
FROM pollutant_sample AS p_s
INNER JOIN taken_at AS t_a
	ON p_s.sample_id = t_a.sample_id
INNER JOIN is_type
    ON is_type.sample_id = p_s.id
INNER JOIN pollutant_type AS p_t
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_county
    ON t_a.site_num = in_county.site_num
INNER JOIN county
    ON county.county_code = in_county.county_code
WHERE p_t.name = user_provided_pollutant_name
ORDER BY county.county_name, p_s.date_local
