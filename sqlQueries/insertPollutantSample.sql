--as with the queryByState these are mostly drafts and should be
--modified for the API we need

--given a sample site that already exists
INSERT INTO pollutant_sample
VALUES (generated_sample_id, user_given_date, user_given_max_hour, user_given_aqi,
	user_given_units, user_given_mean)

--Do we restrict samples submitted to the types we already have?

INSERT INTO is_type
VALUES (user_chosen_type_id, generated_sample_id)

INSERT INTO taken_at
VALUES (generated_sample_id, user_chosen_site_num)

--on insertion, IN ORDER:
--create pollutant_sample tuple
--create new relation between new p_s tuple and existing pollutant_type
--create new relation between new p_s tuple and existing survey_site
