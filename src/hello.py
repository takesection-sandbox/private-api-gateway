import json

def lambda_handler(event, context):
    body = {
        "message": "Hello World"
    }
    return {
        "statusCode": 200,
        "body": json.dumps(body)
    }