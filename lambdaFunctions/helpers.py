def makeResponse(statusCode, body):
    return {
        'statusCode': statusCode,
        'body': body,
        'headers': {
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        }
    }

