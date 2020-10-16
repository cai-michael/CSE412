-- generic deletion query for all tables

-- Delete pollutant samples by id
-- ON DELETE CASCADE lets us delete just the 
-- pollutant_sample tuple
DELETE
FROM pollutant_sample
WHERE id = user_selected_id

-- Survey Site
DELETE
FROM taken_at
WHERE site_num = user_selected_site_num;

DELETE
FROM in_county
WHERE site_num = user_selected_site_num;

DELETE
FROM in_state
WHERE site_num = user_selected_site_num;

DELETE
FROM survey_site
WHERE site_num = user_selected_site_num;

-- Pollutant Type
DELETE
FROM is_type
WHERE sample_id = user_selected_sample_id;

DELETE
FROM pollutant_type
WHERE name = user_given_name

DELETE
FROM is_type
WHERE type_id = user_selected_type_id
	AND sample_id = user_selected_sample_id;

-- County
DELETE
FROM county
WHERE county_code = user_selected_county_code;

DELETE
FROM in_county
WHERE county_code = user_selected_county_code;

-- State
DELETE
FROM in_state
WHERE state_code = user_selected_state_code;

DELETE
FROM state
WHERE state_code = user_selected_state_code;