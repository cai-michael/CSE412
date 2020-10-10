-- Query for displaying all of a site's pollution data
--Inputs (user_site_num)
SELECT p_s.date_local, p_s.id, p_s.id
FROM pollutant_sample AS p_s
  INNER JOIN taken_at AS t_a
    ON p_s.sample_id == t_a.sample_id
  INNER JOIN survey_site AS s_s
    ON t_a.site_num == s_s.site_num
WHERE s_s.site_num == user_site_num
ORDER BY date_local

-- Query for displaying all of a site's pollution data within a given timeframe
--Inputs (user_site_num, lower_date_limit, upper_date_limit)
SELECT p_s.date_local, p_s.id, p_s.id
FROM pollutant_sample AS p_s
  INNER JOIN taken_at AS t_a
    ON p_s.sample_id == t_a.sample_id
  INNER JOIN survey_site AS s_s
    ON t_a.site_num == s_s.site_num
WHERE s_s.site_num == user_site_num
  AND date_local >= lower_date_limit
  AND date_local <= upper_date_limit
ORDER BY date_local