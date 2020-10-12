----No differentiation -----------------
--Returns all samples for a particular pollutant within the given timeframe and their site numbers
--The data is ordered by date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT psample.date_local, psample.name, psample.mean, ta.site_num 
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON pollutant_type.id = is_type.type_id
WHERE ptype.name = user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY psample.date_local

--Returns all samples for a particular pollutant and their site numbers
--The data is ordered by date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT psample.date_local, psample.name, psample.mean, ta.site_num 
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON pollutant_type.id = is_type.type_id
WHERE ptype.name = user_provided_pollutant_name
ORDER BY psample.date_local

----Add State Information---------------------
--Returns all samples for a particular pollutant within the given timeframe and their state
--The data is ordered by state and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT psample.date_local, psample.name, psample.mean, state.state_name 
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_state
    ON ta.site_num = in_state.site_num
INNER JOIN state
    ON state.state_code = in_state.state_code
WHERE ptype.name = user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY state.state_name, psample.date_local

--Returns all samples for a particular pollutant and their state
--The data is ordered by state and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT psample.date_local, psample.name, psample.mean, state.state_name 
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_state
    ON ta.site_num = in_state.site_num
INNER JOIN state
    ON state.state_code = in_state.state_code
WHERE ptype.name = user_provided_pollutant_name
ORDER BY state.state_name, psample.date_local

----Add County Information--------------------
--Returns all samples for a particular pollutant within the given timeframe and their county
--The data is ordered by county and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name, provided_lower_date_limit, provided_upper_date_limit)
SELECT psample.date_local, psample.name, psample.mean, county.county_name
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_county
    ON ta.site_num = in_county.site_num
INNER JOIN county
    ON county.county_code = in_county.county_code
WHERE ptype.name = user_provided_pollutant_name
	AND date_local >= provided_lower_date_limit
	AND date_local <= provided_upper_date_limit
ORDER BY county.county_name, psample.date_local

--Returns all samples for a particular pollutant and their county
--The data is ordered by county and date_local which is useful for creating a multi line linegraph
--Inputs (user_provided_pollutant_name)
SELECT psample.date_local, psample.name, psample.mean, county.county_name
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.sample_id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON pollutant_type.id = is_type.type_id
INNER JOIN in_county
    ON ta.site_num = in_county.site_num
INNER JOIN county
    ON county.county_code = in_county.county_code
WHERE ptype.name = user_provided_pollutant_name
ORDER BY county.county_name, psample.date_local
