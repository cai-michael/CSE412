import lambda_function
import json

passedJson = {
    "queryType": "pollutantByStateAndType",
    "parameters": {
        "pollutant" : "CO",
        "state": "California"
    }
}

body = {
    'body': json.dumps(passedJson)
}

print(lambda_function.lambda_handler(body, None))