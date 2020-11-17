import controller

passedJson = {
    "queryType": "pollutantByState",
    "parameters": {
        "state" : "Arizona"
    }
}
controller.handler(passedJson, None)