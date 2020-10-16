import json
#import psycopg2

with open("../config.json") as json_config_file:
    config = json.load(json_config_file)['database']

#conn = psycopg2.connect("dbname=config['dbname'], user=config['username'], password=['password'], host=['hosturl']")

import csv
csvData = open('../sampleData.csv', newline='')
csvReader = csv.DictReader(csvData, delimiter=',', quotechar='|')
for row in csvReader:
        
        #pollutant_type
        #pollutant_sample
        #is_type
        #survey_site
        #taken_at
        #county
        #in_county
        #state
        #in_state