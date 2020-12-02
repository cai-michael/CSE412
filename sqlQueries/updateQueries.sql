-- Pollutant Sample
UPDATE pollutant_sample
SET date_local = user_given_date_local,
	max_hour = user_given_max_hour,
	max_value = user_given_max_value,
	aqi = user_given_aqi,
	units = user_given_units,
	mean = user_given_mean
WHERE id = user_given_id;

-- Survey Site
UPDATE survey_site
SET address = user_given_address, city = user_given_city
WHERE site_num = user_given_site_num;

-- State
UPDATE state
SET state_name = user_given_state_name
WHERE state_code = user_given_state_code;

-- Pollutant Type
UPDATE pollutant_type
SET name = user_given_name
WHERE id = user_given_id;

-- County
UPDATE county
SET county_name = user_given_county_name
WHERE county_code = user_given_county_code;

