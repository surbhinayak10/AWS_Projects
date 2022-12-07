import json
import boto3
from datetime import datetime

s3 = boto3.client('s3')
now = datetime.now()
current_time = now.strftime("%H:%M:%S")

def lambda_handler(event, context):
    
	bucket ='step-transactions'

	transactionToUpload = {}
	transactionToUpload['transactionId'] = '12345'
	transactionToUpload['type'] = event['TransactionType']
	transactionToUpload['amount'] = 20
	transactionToUpload['message'] = 'From Process Refund'
	transactionToUpload['Time'] = current_time

	fileName = 'refund/' + current_time + '.json'

	uploadByteStream = bytes(json.dumps(transactionToUpload).encode('UTF-8'))

	s3.put_object(Bucket=bucket, Key=fileName, Body=uploadByteStream)

	print('Put Complete')

