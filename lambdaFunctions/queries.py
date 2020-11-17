def pollutantByState(parameters, cursor):
    stateName = (parameters['state'], )
    findStateQuery =  """SELECT state_code FROM state
                        WHERE state_name = %s;""" # Note: no quotes
    cursor.execute(findStateQuery, stateName)
    results = cursor.fetchall()
    
    stateCode = results[0][0]

    findpollutantsQuery = f"""SELECT psample.date_local, psample.id, ptype.name, psample.mean
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
                            ORDER BY date_local"""

    cursor.execute(findpollutantsQuery)
    results = cursor.fetchall()

    return results