import lambda_function
import json

passedJson = {
    "queryType": "pollutantByState",
    "parameters": {
        "state" : "Arizona"
    }
}

body = {
    'body': json.dumps(passedJson)
}

lambda_function.lambda_handler(body, None)