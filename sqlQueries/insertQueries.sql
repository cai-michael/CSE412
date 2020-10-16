
-- Pollutant Sample
INSERT INTO pollutant_sample
VALUES (DEFAULT, user_given_date, user_given_max_hour, user_given_max_value, user_given_aqi,
	user_given_units, user_given_mean) RETURNING id

INSERT INTO is_type
VALUES (user_chosen_type_id, generated_sample_id)

INSERT INTO taken_at
VALUES (generated_sample_id, user_chosen_site_num)

-- Survey Site
INSERT INTO survey_site
VALUES (DEFAULT, user_given_address, user_given_city) RETURNING site_num;

INSERT INTO in_county
VALUES (DEFAULT, generated_site_num, user_chosen_county_code);

INSERT INTO in_state
VALUES (DEFAULT, generated_site_num, user_chosen_state_code);

-- Pollutant Type
INSERT INTO pollutant_type
VALUES (DEFAULT, user_given_name) RETURNING id;

-- County
INSERT INTO county
VALUES (DEFAULT, user_given_county_name) RETURNING county_code;

-- State
INSERT INTO state
VALUES (DEFAULT, user_given_state_name) RETURNING state_code;
