import re
from psycopg2 import Error

def addState(cursor, stateId, stateName):
    try:
        cursor.execute(f'INSERT INTO state VALUES({stateId}, \'{stateName}\')')
    except Error as e:
        return [e]
    return []

def addCounty(cursor, countyId, countyName):
    cleanedCountyName = cleanApostrophes(countyName)
    try:
        cursor.execute(f'INSERT INTO county VALUES({countyId}, \'{cleanedCountyName}\')')
    except Error as e:
        return [e]
    return []

def populateTypes(cursor, pTypes):
    try:
        for typeName, typeId in pTypes.items():
            cursor.execute(f'INSERT INTO pollutant_type VALUES({typeId}, \'{typeName}\')')
    except Error as e:
        return [e]
    return []

def addSite(cursor, siteNum, address, city, state, county):
    cleanedAddress = cleanApostrophes(address)
    cleanedCity = cleanApostrophes(city)
    try:
        cursor.execute(f'INSERT INTO survey_site VALUES({siteNum}, \'{cleanedAddress}\', \'{cleanedCity}\')')
        cursor.execute(f'INSERT INTO in_county VALUES({siteNum}, {county})')
        cursor.execute(f'INSERT INTO in_state VALUES({siteNum}, {state})')
    except Error as e:
        return [e]
    return []

def addSample(cursor, uniqueId, maxHour, maxValue, aqi, units, mean, siteNum, pNum, dateLocal):
    try:
        cursor.execute(f'INSERT INTO pollutant_sample VALUES({uniqueId}, \'{dateLocal}\', {maxHour}, {maxValue}, {aqi}, \'{units}\', {mean})')
        cursor.execute(f'INSERT INTO taken_at VALUES({uniqueId}, {siteNum})')
        cursor.execute(f'INSERT INTO is_type VALUES({pNum}, {uniqueId})')
    except Error as e:
        return [e]
    return []

def alterSequences(cursor, maxStateId, maxCountyId, maxSiteId):
    try:
        cursor.execute(f'ALTER SEQUENCE state_state_code_seq RESTART WITH {maxStateId}')
        cursor.execute(f'ALTER SEQUENCE survey_site_site_num_seq RESTART WITH {maxSiteId}')
        cursor.execute(f'ALTER SEQUENCE county_county_code_seq RESTART WITH {maxCountyId}')
    except Error as e:
        return [e]
    return []

def cleanApostrophes(name):
    return re.sub('\'', '\'\'', name)