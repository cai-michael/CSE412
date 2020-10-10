INSERT INTO state
VALUES (DEFAULT, user_given_state_name) RETURNING state_code;
