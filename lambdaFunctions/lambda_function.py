import sys
import logging
import psycopg2
import os
import json
from queries import *

# DBMS Settings
"""
# This is for the AWS Lambda
dbname = os.environ['dbname']
username = os.environ['username']
password = os.environ['password']
hosturl = os.environ['hosturl']
"""

# This is for Local Testing
# Open Config File for Database Credentials
with open("../config.json") as json_config_file:
    config = json.load(json_config_file)['database']

# Make Databse Connection
dbname = config['dbname']
username = config['username']
password = config['password']
hosturl = config['hosturl']

# Make Databse Connection
conn = psycopg2.connect(dbname=dbname, user=username, password=password, host=hosturl)
cursor = conn.cursor()

# Create a Dictionary of Functions to Call
queries = {
    "testRestAPI": testRestAPI,
    "pollutantByState": pollutantByState
}

def lambda_handler(event, context):
    """
    This function handles input and determines which query to execute
    """
    body = json.loads(event['body'])
    try:
        queryToCall = body['queryType']
    except:
        res = f'Could not find your query/Has not been implemented: {queryToCall}'
        return {
            'statusCode': 400,
            'body': res
        }
    try:
        returnValue = queries[queryToCall](body['parameters'], cursor)
        conn.commit()
    except:
        return {
            'statusCode': 500,
            'body': 'Something went wrong with the query'
        }
    
    return {
        'statusCode': 200,
        'body': json.dumps(returnValue, indent=4, sort_keys=True, default=str)
    }