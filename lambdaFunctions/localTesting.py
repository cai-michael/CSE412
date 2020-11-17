import lambda_function

passedJson = {
    "queryType": "pollutantByState",
    "parameters": {
        "state" : "Arizona"
    }
}

lambda_function.lambda_handler(passedJson, None)