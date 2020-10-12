-- Delete pollutant samples by id
-- ON DELETE CASCADE lets us delete just the 
-- pollutant_sample tuple

DELETE
FROM pollutant_sample
WHERE id = user_selected_id
