-- Query for displaying all of a site's pollution data
--Inputs (user_site_num)
SELECT psample.date_local, psample.id, ptype.name, psample.mean
FROM pollutant_sample AS psample
  INNER JOIN taken_at AS ta
    ON psample.id = ta.sample_id
  INNER JOIN survey_site AS site
    ON ta.site_num = site.site_num
  INNER JOIN is_type AS it
    ON psample.id = it.sample_id
  INNER JOIN pollutant_type AS ptype
    ON ptype.id = it.type_id
WHERE site.site_num = user_site_num
ORDER BY date_local

-- Query for displaying all of a site's pollution data within a given timeframe
--Inputs (user_site_num, lower_date_limit, upper_date_limit)
SELECT psample.date_local, psample.id, ptype.name, psample.mean
FROM pollutant_sample AS psample
  INNER JOIN taken_at AS ta
    ON psample.id = ta.sample_id
  INNER JOIN survey_site AS site
    ON ta.site_num = site.site_num
  INNER JOIN is_type AS it
    ON psample.id = it.sample_id
  INNER JOIN pollutant_type AS ptype
    ON ptype.id = it.type_id
WHERE site.site_num = user_site_num
  AND date_local >= lower_date_limit
  AND date_local <= upper_date_limit
ORDER BY date_local
