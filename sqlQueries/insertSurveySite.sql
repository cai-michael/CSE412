INSERT INTO survey_site
VALUES (DEFAULT, user_given_address, user_given_city) RETURNING site_num;

INSERT INTO in_county
VALUES (DEFAULT, generated_site_num, user_chosen_county_code);

INSERT INTO in_state
VALUES (DEFAULT, generated_site_num, user_chosen_state_code);
