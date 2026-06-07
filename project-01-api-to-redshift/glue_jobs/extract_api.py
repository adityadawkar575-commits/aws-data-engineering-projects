import json
import boto3
import requests

bucket_name = "api-etl-project-bucket"
s3 = boto3.client("s3")

apis = {
    "users": "https://jsonplaceholder.typicode.com/users",
    "posts": "https://jsonplaceholder.typicode.com/posts",
    "comments": "https://jsonplaceholder.typicode.com/comments"
}

for dataset_name, url in apis.items():
    response = requests.get(url)
    data = response.json()

    s3.put_object(
        Bucket=bucket_name,
        Key=f"raw/{dataset_name}/{dataset_name}.json",
        Body=json.dumps(data)
    )

    print(f"{dataset_name} loaded successfully")