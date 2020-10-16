import json
#import psycopg2

with open("../config.json") as json_config_file:
    config = json.load(json_config_file)['database']

#conn = psycopg2.connect("dbname=config['dbname'], user=config['username'], password=['password'], host=['hosturl']")

import csv
csvData = open('../sampleData.csv', newline='')
csvReader = csv.reader(csvData, delimiter=',', quotechar='|')
for row in csvReader:
        print(', '.join(row))
