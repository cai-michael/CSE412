--Date limits provided
--Not sure what data needs to be returned to make a graph out of,
--SELECT statement can be modified
SELECT DateLocal, p_s.id, units
FROM pollutant_sample AS p_s, in_state, taken_at AS t_a
WHERE DateLocal >= provided_lower_date_limit
	AND DateLocal <= provided_upper_date_limit
	AND p_s.sample_id == taken_at.sample_id
	AND taken_at.site_num == in_state.site_num
	AND in_state.state_code == user_provided_state_code

--Date limits not provided
SELECT p_s.DateLocal, p_s.id, p_s.units
FROM pollutant_sample AS p_s, taken_at, in_state	
WHERE p_s.sample_id == taken_at.sample_id
	AND taken_at.site_num  == in_state.site_num
	AND in_state.state_code == user_provided_state_code

--Neither query needs to select from survey_site, unless
--you want City to be available in the return

--also not sure how to put these queries in a format that they
--become, like, usable functions
