SELECT pollutant_sample.*
FROM pollutant_sample
INNER JOIN taken_at
    ON pollutant_sample.id = taken_at.sample_id
INNER JOIN survey_site
    ON survey_site.site_num = taken_at.site_num
WHERE pollutant_sample.id = user_sample_id
    OR (survey_site.address = user_address AND pollutant_sample.date_local = user_date)
    OR (survey_site.site_id = user_site_id AND pollutant_sample.date_local = user_date)