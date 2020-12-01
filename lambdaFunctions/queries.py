def testRestAPI(parameters, cursor):
    testQuery = 'SELECT * FROM pollutant_type'
    cursor.execute(testQuery)
    results = cursor.fetchall()
    return results

def pollutantByState(parameters, cursor):
    stateName = (parameters['state'], )
    stateCode = findStateCode(stateName, cursor)

    findpollutantsQuery =  f"""SELECT psample.date_local, ptype.name, AVG(psample.mean)
                            FROM pollutant_sample AS psample
                            INNER JOIN taken_at AS ta
                                ON psample.id = ta.sample_id
                            INNER JOIN in_state
                                ON ta.site_num = in_state.site_num
                            INNER JOIN is_type AS it
                                ON psample.id = it.sample_id
                            INNER JOIN pollutant_type AS ptype
                                ON ptype.id = it.type_id
                            WHERE in_state.state_code = {stateCode}
                            GROUP BY ptype.name, date_local
                            ORDER BY date_local, ptype.name;"""
    
    cursor.execute(findpollutantsQuery)
    results = cursor.fetchall()

    return results

def pollutantByStateAndType(parameters, cursor):
    stateName = (parameters['state'], )
    pollutantName = (parameters['pollutant'])
    stateCode = findStateCode(stateName, cursor)

    findpollutantsQuery =  f"""SELECT psample.date_local, ptype.name, AVG(psample.mean)
                            FROM pollutant_sample AS psample
                            INNER JOIN taken_at AS ta
                                ON psample.id = ta.sample_id
                            INNER JOIN in_state
                                ON ta.site_num = in_state.site_num
                            INNER JOIN is_type AS it
                                ON psample.id = it.sample_id
                            INNER JOIN pollutant_type AS ptype
                                ON ptype.id = it.type_id
                            WHERE in_state.state_code = {stateCode}
                                AND ptype.name = '{pollutantName}'
                            GROUP BY ptype.name, date_local
                            ORDER BY date_local, ptype.name;"""
    
    cursor.execute(findpollutantsQuery)
    results = cursor.fetchall()

    return results

def pollutantBySite(parameters, cursor):
    cityName = (parameters['city'], )
    findSiteQuery =  """SELECT site_num FROM survey_site
                        WHERE city = %s;""" # Note: no quotes
    cursor.execute(findSiteQuery, cityName)
    results = cursor.fetchall()
    
    siteNum = results[0][0]

    findpollutantsQuery =  f"""SELECT psample.date_local, psample.id, ptype.name, psample.mean
                                FROM pollutant_sample AS psample
                                INNER JOIN taken_at AS ta
                                    ON psample.id = ta.sample_id
                                INNER JOIN survey_site AS site
                                    ON ta.site_num = site.site_num
                                INNER JOIN is_type AS it
                                    ON psample.id = it.sample_id
                                INNER JOIN pollutant_type AS ptype
                                    ON ptype.id = it.type_id
                                WHERE site.site_num = {siteNum}
                                ORDER BY ptype.name, date_local;"""
                                    
    cursor.execute(findpollutantsQuery)
    results = cursor.fetchall()
    return results

def pollutantBySiteAndType(parameters, cursor):
    cityName = (parameters['city'], )
    pollutantName = (parameters['pollutant'])
    findSiteQuery =  """SELECT site_num FROM survey_site
                        WHERE city = %s;""" # Note: no quotes
    cursor.execute(findSiteQuery, cityName)
    results = cursor.fetchall()
    
    siteNum = results[0][0]

    findpollutantsQuery =  f"""SELECT psample.date_local, psample.id, ptype.name, psample.mean
                                FROM pollutant_sample AS psample
                                INNER JOIN taken_at AS ta
                                    ON psample.id = ta.sample_id
                                INNER JOIN survey_site AS site
                                    ON ta.site_num = site.site_num
                                INNER JOIN is_type AS it
                                    ON psample.id = it.sample_id
                                INNER JOIN pollutant_type AS ptype
                                    ON ptype.id = it.type_id
                                WHERE site.site_num = {siteNum}
                                    AND ptype.name = '{pollutantName}'
                                ORDER BY ptype.name, date_local;"""
                                    
    cursor.execute(findpollutantsQuery)
    results = cursor.fetchall()
    return results

def pollutantByCountyAndType(parameters, cursor):
    countyName = (parameters['county'])
    pollutantName = (parameters['pollutant'])
    countyCode = findCountyCode(countyName, cursor)
    #should we be be slecting AVG(psample.mean) or just psample.mean
    findpollutantsQuery =  f"""SELECT psample.date_local, ptype.name, AVG(psample.mean)
                        FROM pollutant_sample AS psample
                        INNER JOIN taken_at AS ta
                            ON psample.id = ta.sample_id
                        INNER JOIN in_county
                            ON ta.site_num = in_county.site_num
                        INNER JOIN is_type AS it
                            ON psample.id = it.sample_id
                        INNER JOIN pollutant_type AS ptype
                            ON ptype.id = it.type_id
                        WHERE in_county.county_code = {countyCode}
                            AND ptype.name = '{pollutantName}'
                        GROUP BY ptype.name, date_local
                        ORDER BY date_local, ptype.name;"""
    cursor.execute(findpollutantsQuery)
    results = cursor.fetchall()

    return results

def siteMeansForSpecifiedPollutant(parameters, cursor):
    pollutantName = (parameters['pollutant'], )
    findpollutantsQuery = """SELECT psample.date_local, AVG(psample.mean), ta.site_num 
                            FROM pollutant_sample AS psample
                            INNER JOIN taken_at AS ta
                                ON psample.id = ta.sample_id
                            INNER JOIN is_type
                                ON is_type.sample_id = psample.id
                            INNER JOIN pollutant_type AS ptype
                                ON ptype.id = is_type.type_id
                            WHERE ptype.name = %s
                            GROUP BY psample.date_local, ta.site_num
                            ORDER BY psample.date_local, ta.site_num"""
    cursor.execute(findpollutantsQuery, pollutantName)
    results = cursor.fetchall()

    return results

# delete queries


def deleteState(parameters, cursor):
    stateName = parameters['state']
    stateQuery = "DELETE * FROM state WHERE state_name = %s"
    cursor.execute(stateQuery, stateName)
    results = cursor.fetchall()
    stateCode = results[0][0]
    return f"Successfully deleted {stateName} with ID {stateCode} from table."


def deleteSite(parameters, cursor):
    siteNum = parameters['site_num']
    # ON DELETE CASCADE so only delete survey_site table entry
    siteQuery = "DELETE * FROM survey_site WHERE site_num = %s"
    cursor.execute(siteQuery, siteNum)
    results = cursor.fetchall()
    return f"Successfully deleted site with ID {siteNum} from table."


def deletePollutantSample(parameters, cursor):
    sampleId = parameters['id']
    # ON DELETE CASCADE
    sampleQuery = "DELETE * FROM pollutant_sample WHERE id = %s"
    cursor.execute(sampleQuery, sampleId)
    results = cursor.fetchall()
    return f"Successfully deleted sample with ID {sampleId} from table."


def deleteCounty(parameters, cursor):
    countyCode = parameters['county_code']
    countyQuery = "DELETE * FROM county WHERE county_code = %s"
    cursor.execute(countyQuery, countyCode)
    results = cursor.fetchall()
    countyName = results[0][1]
    return f"Successfully deleted {countyName} County with ID {countyCode} from table."

#insert queries
def insertState(parameters, cursor):
    stateName = (parameters['state'], )
    stateQuery = "INSERT INTO state VALUES (DEFAULT, %s) RETURNING state_code"
    cursor.execute(stateQuery, stateName)
    results = cursor.fetchall()
    
    stateCode = results[0][0]
    return f"Successfully inserted {stateName} as id {stateCode}"

def insertCounty(parameters, cursor):
    countyName = (parameters['state'], )
    countyQuery = "INSERT INTO county VALUES (DEFAULT, %s) RETURNING county_code;"
    cursor.execute(countyQuery, countyName)
    results = cursor.fetchall()
    
    countyCode = results[0][0]
    return f"Successfully inserted {countyName} as id {countyCode}"

def insertSite(parameters, cursor):
    county = (parameters['county'], )
    city = (parameters['city'], )
    state = (parameters['state'], )
    address = (parameters['address'], )
    
    siteQuery = "INSERT INTO survey_site VALUES (DEFAULT, %s, %s) RETURNING site_num"
    cursor.execute(siteQuery, address, city)
    results = cursor.fetchall()
    siteNum = results[0][0]


    inCounty = "INSERT INTO in_county VALUES (DEFAULT, generated_site_num, user_chosen_county_code)"
    inState = "INSERT INTO in_state VALUES (DEFAULT, generated_site_num, user_chosen_state_code)"

def insertPollutantSample(parameters, cursor):
    pollutantName = (parameters['pollutant'], )

    maxHour = (parameters['maxhour'], )
    date = (parameters['date'], )
    value = (parameters['value'], )
    aqi = (parameters['aqi'], )
    units = (parameters['units'], )
    mean = (parameters['mean'], )

    insertPollutant =  """INSERT INTO pollutant_sample
                            VALUES (DEFAULT, user_given_date, user_given_max_hour, user_given_max_value, user_given_aqi,
	                        user_given_units, user_given_mean) RETURNING id"""
                                    
    cursor.execute(insertPollutant, pollutantName)
    results = cursor.fetchall()

    sampleId = results[0][0]

    insertType = "INSERT INTO is_type VALUES (user_chosen_type_id, generated_sample_id)"
    insertSite = "INSERT INTO taken_at VALUES (generated_sample_id, user_chosen_site_num)"

    return results
    
# Helper Functions
def findCountyCode(county, cursor):
    findCountyQuery =  """SELECT county_code FROM county
                        WHERE county_name = %s;""" # Note: no quotes
    cursor.execute(findCountyQuery, county)
    results = cursor.fetchall()
    countyCode = results[0][0]
    return countyCode

def findStateCode(state, cursor):
    findStateQuery =  """SELECT state_code FROM state
                        WHERE state_name = %s;""" # Note: no quotes
    cursor.execute(findStateQuery, state)
    results = cursor.fetchall()
    stateCode = results[0][0]
    return stateCode
