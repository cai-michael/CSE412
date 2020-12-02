import lambda_function
import json

passedJson = {
    "queryType": "insertPollutantSample",
    "parameters": {
        "pollutant" : "CO",
        "address" : "1234 Made Up Avenue",
        "state": "Wyoming", 
        "county": "Laramie",
        "city": "Cheyenne",
        "maxhour": "12",
        "date": "12/1/2020",
        "maxvalue": "10",
        "aqi": "10",
        "units": "parts per googleplex",
        "mean": "2"
    }
}

body = {
    'body': json.dumps(passedJson)
}

print(lambda_function.lambda_handler(body, None))