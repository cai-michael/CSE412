UPDATE pollutant_sample
SET date_local = user_given_date_local,
	max_hour = user_given_max_hour,
	aqi = user_given_aqi,
	units = user_given_units,
	mean = user_given_mean
WHERE id = user_given_id;
