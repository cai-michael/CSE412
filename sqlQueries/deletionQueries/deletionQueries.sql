-- generic deletion query for all tables

DELETE
FROM taken_at
WHERE site_num = user_selected_site_num
	AND sample_id = user_selected_sample_id

DELETE
FROM survey_site
WHERE site_num = user_selected_site_num

DELETE
FROM is_type
WHERE type_id = user_selected_type_id
	AND sample_id = user_selected_sample_id

DELETE
FROM county
WHERE county_code = user_selected_county_code

DELETE
FROM in_county
WHERE site_num = user_selected_site_num
	AND county_code = user_selected_county_code

DELETE
FROM state
WHERE state_code = user_selected_state_code

DELETE
FROM in_state
WHERE site_num = user_selected_site_num
	AND state_code = user_selected_state_code


-- delete a type of pollutant, by id
-- may not be necessary for presentation, but can be used for 
-- DB maintenance

-- we have ON DELETE CASCADE for all necessary tables
-- so we can just delete the sample from the pollutant_type table
DELETE
FROM pollutant_type
WHERE name = user_given_name

-- Delete pollutant samples by id
-- ON DELETE CASCADE lets us delete just the 
-- pollutant_sample tuple
DELETE
FROM pollutant_sample
WHERE id = user_selected_id