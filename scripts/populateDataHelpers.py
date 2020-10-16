def addState(cursor, stateId, stateName):
    cursor.execute(f'INSERT INTO state VALUES({stateId}, \'{stateName}\')')

def addCounty(cursor, countyId, countyName):
    cursor.execute(f'INSERT INTO county VALUES({countyId}, \'{countyName}\')')

def populateTypes(cursor, pTypes):
    for typeName, typeId in pTypes.items():
        cursor.execute(f'INSERT INTO pollutant_type VALUES({typeId}, \'{typeName}\')')

def addSite(cursor, siteNum, address, city, state, county):
    cursor.execute(f'INSERT INTO survey_site VALUES({siteNum}, \'{address}\', \'{city}\')')
    cursor.execute(f'INSERT INTO in_county VALUES({siteNum}, {county})')
    cursor.execute(f'INSERT INTO in_state VALUES({siteNum}, {state})')

def addSample(cursor, uniqueId, maxHour, maxValue, aqi, units, mean, siteNum, pNum, dateLocal):
    cursor.execute(f'INSERT INTO pollutant_sample VALUES({uniqueId}, \'{dateLocal}\', {maxHour}, {maxValue}, {aqi}, \'{units}\', {mean})')
    cursor.execute(f'INSERT INTO taken_at VALUES({uniqueId}, {siteNum})')
    cursor.execute(f'INSERT INTO is_type VALUES({pNum}, {uniqueId})')

def alterSequences(cursor, maxStateId, maxCountyId, maxSiteId):
    cursor.execute(f'ALTER SEQUENCE state_id_seq RESTART WITH {maxStateId}')
    cursor.execute(f'ALTER SEQUENCE site_id_seq RESTART WITH {maxSiteId}')
    cursor.execute(f'ALTER SEQUENCE county_id_seq RESTART WITH {maxCountyId}')
