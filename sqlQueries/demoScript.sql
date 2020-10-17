-- Drop all of the tables (run dropTables.sql) and create them again before running the demo

-- Run populateData.py using Python 3 to import some data into the tables

-- Uncomment the one to demonstrate for the sake of time
-- Main Tables to show SELECT *
--SELECT * FROM pollutant_sample;
--SELECT * FROM pollutant_type;
--SELECT * FROM survey_site;
--SELECT * FROM county;
--SELECT * FROM state;

-- Relationship Tables to show SELECT *
--SELECT * FROM is_type;
--SELECT * FROM taken_at;
--SELECT * FROM in_county;
--SELECT * FROM in_state;

-- Demonstrating Insert
INSERT INTO pollutant_sample VALUES(DEFAULT, '10-17-2020', 12, 1000, 1000, 'parts per 100', 99.999);
SELECT * FROM pollutant_sample WHERE date_local = '10-17-2020';

-- Demonstrating Update
UPDATE pollutant_sample SET units = 'parts per googleplex' WHERE date_local = '10-17-2020';
SELECT * FROM pollutant_sample WHERE units = 'parts per googleplex';

-- Demonstrating Delete
DELETE FROM pollutant_sample WHERE units = 'parts per googleplex';
SELECT * FROM pollutant_sample WHERE units = 'parts per googleplex';

-- Demonstrate Two Selection Queries
-- We can create a line graph from the information from 1645 E ROOSEVELT ST-CENTRAL PHOENIX STN
-- Each line is a pollutant
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
WHERE site.address = '1645 E ROOSEVELT ST-CENTRAL PHOENIX STN'
ORDER BY ptype.name, date_local;

-- Or Show 20 years of Nitrogen Dioxide Data from multiple counties
-- Each line is a county
SELECT psample.date_local, ptype.name, psample.mean, county.county_name
FROM pollutant_sample AS psample
INNER JOIN taken_at AS ta
	ON psample.id = ta.sample_id
INNER JOIN is_type
    ON is_type.sample_id = psample.id
INNER JOIN pollutant_type AS ptype
    ON ptype.id = is_type.type_id
INNER JOIN in_county
    ON ta.site_num = in_county.site_num
INNER JOIN county
    ON county.county_code = in_county.county_code
WHERE ptype.name = 'NO2'
	AND date_local >= '1-1-2000'
	AND date_local <= '1-1-2020'
ORDER BY county.county_name, psample.date_local;
