import lambda_function
import json

userChoice = 0

while userChoice != 5:
    userChoice = int(input("What would you like to insert to the database?\n1. State\n2. County\n3. Pollutant Site\n4. Pollutant Sample\n5. Quit\n"))
    if userChoice < 5 and userChoice > 0:
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
            address = input("Please input an address: ")
            city = input("Please input a city: ")
            passedJson = {
                "queryType": "insertSite",
                "parameters": {
                    "county": countyName, 
                    "state": stateName,
                    "address": address,
                    "city": city
                }
            }
        else:
            pollutantName = input("What pollutant is it?: ")
            address = input("Please input the address: ")
            maxHour = input("At what point what the pollutant most concentrated?: ")
            date = input("What date is this sample?: ")
            maxValue = input("What is the max concentration reached?: ")
            aqi = input("Please input the aqi: ")
            units = input("Please input the units of measurement: ")
            mean = input("Please input the mean concentration: ")
            passedJson = {
                "queryType": "insertPollutantSample",
                "parameters": {
                    "pollutant": pollutantName, 
                    "address": address,
                    "maxhour": maxHour,
                    "date": date,
                    "maxvalue": maxValue,
                    "aqi": aqi,
                    "units": units,
                    "mean": mean
                }
            }
        
        body = {
            'body': json.dumps(passedJson)
        }

        print(lambda_function.lambda_handler(body, None)['body'])

    elif userChoice != 5:
        print("Invalid Option!")