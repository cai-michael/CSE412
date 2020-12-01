import lambda_function
import json

passedJson = {
    "queryType": "pollutantByCountyAndType",
    "parameters": {
        "pollutant" : "CO",
        "state": "Arizona", 
        "county": "Maricopa",
        "city": "Phoenix"
    }
}

body = {
    'body': json.dumps(passedJson)
}

print(lambda_function.lambda_handler(body, None))