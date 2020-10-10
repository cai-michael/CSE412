INSERT INTO county
VALUES (DEFAULT, user_given_county_name) RETURNING county_code;
