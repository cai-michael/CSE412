import lambda_function
import json

passedJson = {
    "queryType": "siteMeansForSpecifiedPollutant",
    "parameters": {
        "pollutant" : "CO"
    }
}

body = {
    'body': json.dumps(passedJson)
}

print(lambda_function.lambda_handler(body, None))