import json
import csv
import psycopg2
import populateDataHelpers as helpers

# Path to the CSV we want to populate from
dataPath = 'sampleData.csv'

# Open Config File for Database Credentials
with open("config.json") as json_config_file:
    config = json.load(json_config_file)['database']

# Make Databse Connection
conn = psycopg2.connect(dbname=config['dbname'], user=config['username'], password=['password'], host=['hosturl'])
cursor = conn.cursor()

# Create Dictionaries to ensure consistency
pTypes = { 'NO2':1, 'O3':2, 'SO2':3, 'CO':4 }
sites = { }
counties = { }
states = { }

helpers.populateTypes(cursor, pTypes)

# Open the CSV and start populating
counter = 0
csvData = open(dataPath, newline='')
csvReader = csv.DictReader(csvData, delimiter=',', quotechar='|')
for row in csvReader:
    # Populate State if not already
    state = row['State Code']
    if state not in states:
        helpers.addState(cursor, state, row['State'])
        states[state] = row['State']
    
    # Populate County if not already
    county = row['County Code']
    if county not in counties:
        helpers.addCounty(cursor, county, row['County'])
        counties[county] = row['County']
    
    # Populate Sites if not already
    siteNum = row['Site Num']
    if siteNum not in sites:
        helpers.addSite(cursor, siteNum, row['Address'], row['City'], state, county)
        sites[siteNum] = row['Address']
    
    # Grab Date
    dateLocal = row['Date Local']
    
    # Populate Samples
    for pName, pNum in pTypes.items():
        counter += 1
        uniqueId = str(counter)
        units = row[pName + ' Units']
        mean = row[pName + ' Mean']
        maxValue = row[pName + ' 1st Max Value']
        maxHour = row[pName + ' 1st Max Hour']
        aqi = row[pName + ' AQI']
        helpers.addSample(cursor, uniqueId, maxHour, maxValue, aqi, units, mean, siteNum, pNum, dateLocal)
        conn.commit()

# Close Connection
cursor.close()
conn.close()