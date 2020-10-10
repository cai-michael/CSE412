UPDATE survey_site
SET address = user_given_address, city = user_given_city
WHERE site_num = user_given_site_num;
