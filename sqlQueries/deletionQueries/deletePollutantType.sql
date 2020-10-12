-- delete a type of pollutant, by id
-- may not be necessary for presentation, but can be used for 
-- DB maintenance

-- we have ON DELETE CASCADE for all necessary tables
-- so we can just delete the sample from the pollutant_type table

DELETE
FROM pollutant_type
WHERE name = user_given_name


