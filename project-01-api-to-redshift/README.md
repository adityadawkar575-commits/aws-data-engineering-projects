This project demonstrates an end-to-end AWS Data Engineering pipeline that extracts data from REST APIs, stores raw JSON files in Amazon S3, transforms data into Parquet format using AWS Glue and PySpark, and loads curated datasets into Amazon Redshift.

3 External APIs → AWS Glue Job #1 (API Extraction) → S3 JSON Files → AWS Glue Job #2 (JSON → Parquet Transformation) → S3 Parquet Files → AWS Step Function → Redshift COPY Commands → Redshift Tables
