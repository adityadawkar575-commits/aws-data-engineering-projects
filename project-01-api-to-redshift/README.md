This project demonstrates an end-to-end AWS Data Engineering pipeline that extracts data from REST APIs, stores raw JSON files in Amazon S3, transforms data into Parquet format using AWS Glue and PySpark, and loads curated datasets into Amazon Redshift.

3 External APIs
       |
       v
AWS Glue Job #1
(API Extraction)
       |
       v
S3 JSON Files
       |
       v
AWS Glue Job #2
(JSON → Parquet Transformation)
       |
       v
S3 Parquet Files
       |
       v
AWS Step Function
       |
       v
Redshift COPY Commands
       |
       v
Redshift Tables
