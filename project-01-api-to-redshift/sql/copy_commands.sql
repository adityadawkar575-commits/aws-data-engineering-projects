COPY demo.user_address
FROM 's3://YOUR_BUCKET/processed/user_address/'
IAM_ROLE 'YOUR_REDSHIFT_ROLE_ARN'
FORMAT AS PARQUET;

COPY demo.posts
FROM 's3://YOUR_BUCKET/processed/posts/'
IAM_ROLE 'YOUR_REDSHIFT_ROLE_ARN'
FORMAT AS PARQUET;

COPY demo.post_summary
FROM 's3://YOUR_BUCKET/processed/post_summary/'
IAM_ROLE 'YOUR_REDSHIFT_ROLE_ARN'
FORMAT AS PARQUET;

COPY demo.comments
FROM 's3://YOUR_BUCKET/processed/comments/'
IAM_ROLE 'YOUR_REDSHIFT_ROLE_ARN'
FORMAT AS PARQUET;

COPY demo.comment_summary
FROM 's3://YOUR_BUCKET/processed/comment_summary/'
IAM_ROLE 'YOUR_REDSHIFT_ROLE_ARN'
FORMAT AS PARQUET;