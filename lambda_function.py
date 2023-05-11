import json
import requests

def lambda_handler(event, context):
    api_uri = 'https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data'
    headers = {'X-Siemens-Auth': 'test'}
    payload = {
        "subnet_id": "subnet-0d03f542e874e67f3",
        "name": "Andy Pham",
        "email": "andy.pham@siemens.com"
    }

    result = requests.post(api_uri, headers=headers, json=payload)

    return {
        'statusCode': result.status_code,
        'body': result.text
    }
