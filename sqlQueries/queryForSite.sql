SELECT survey_site.*
FROM survey_site 
WHERE survey_site.site_num = user_site_num
    OR survey_site.address = user_address
    OR survey_site.city = user_city