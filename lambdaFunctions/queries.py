def testRestAPI(parameters, cursor):
    testQuery = 'SELECT * FROM pollutant_type'
    cursor.execute(testQuery)
    results = cursor.fetchall()
    return results

def pollutantByState(parameters, cursor):
    stateName = (parameters['state'], )
    findStateQuery =  """SELECT state_code FROM state
                        WHERE state_name = %s;""" # Note: no quotes
    cursor.execute(findStateQuery, stateName)
    results = cursor.fetchall()
    
    stateCode = results[0][0]

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

def siteMeansForSpecifiedPollutant(parameters, cursor):
    pollutantName = (parameters['pollutant'], )
    findpollutantsQuery =  """SELECT psample.date_local, AVG(psample.mean), ta.site_num 
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