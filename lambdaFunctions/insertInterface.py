import lambda_function
import json

userChoice = 0

while userChoice != 5:
    userChoice = int(input("What would you like to insert to the database?\n1. State\n2. County\n3. Pollutant Site\n4. Pollutant Sample\n5. Quit"))
    if userChoice < 5 and userChoice > 4:
        if userChoice == 1:
            stateName = input("Please input a state name: ")
            passedJson = {
                "queryType": "insertState",
                "parameters": {
                    "state": stateName, 
                }
            }
        elif userChoice == 2:
            countyName = input("Please input a county name: ")
            passedJson = {
                "queryType": "insertCounty",
                "parameters": {
                    "county": countyName, 
                }
            }
        elif userChoice == 3:
            countyName = input("Please input a county name: ")
            stateName = input("Please input a state name: ")
            address = input("Please input a state name: ")
            city = input("Please input a state name: ")
            passedJson = {
                "queryType": "insertCounty",
                "parameters": {
                    "county": countyName, 
                }
            }
        elif userChoice == 4:
        else:
        body = {
            'body': json.dumps(passedJson)
        }

        print(lambda_function.lambda_handler(body, None))

    else if userChoice != 5:
        print("Invalid Option!")


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

