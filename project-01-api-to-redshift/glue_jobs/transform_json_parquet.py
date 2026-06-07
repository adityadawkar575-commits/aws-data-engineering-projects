from pyspark.context import SparkContext
from awsglue.context import GlueContext
from pyspark.sql.functions import length

sc = SparkContext()
glueContext = GlueContext(sc)

spark = glueContext.spark_session

bucket = "api-etl-project-bucket"

raw_path = f"s3://{bucket}/raw/"
processed_path = f"s3://{bucket}/processed/"

users_df = spark.read.json(
    f"{raw_path}users/"
)

users_df.printSchema()

users_output_df = users_df.select(
    "id",
    "name",
    "username",
    "email",
    "phone",
    "website"
)

users_output_df.write.mode("overwrite").parquet(
    f"{processed_path}users/"
)

# Create User Address Table
address_df = users_df.selectExpr(
    "id as user_id",
    "address.street",
    "address.suite",
    "address.city",
    "address.zipcode"
)

address_df.write.mode("overwrite").parquet(
    f"{processed_path}user_address/"
)

# Process Posts
posts_df = spark.read.json(
    f"{raw_path}posts/"
)

posts_output_df = posts_df.select(
    "id",
    "userId",
    "title",
    "body"
)
posts_output_df.write.mode("overwrite").parquet(
    f"{processed_path}posts/"
)

post_summary_df = posts_df.select(
    "id",
    length("title").alias("title_length")
)

post_summary_df.write.mode("overwrite").parquet(
    f"{processed_path}post_summary/"
)

comments_df = spark.read.json(
    f"{raw_path}comments/"
)

comments_output_df = comments_df.select(
    "id",
    "postId",
    "name",
    "email",
    "body"
)

comments_output_df.write.mode("overwrite").parquet(
    f"{processed_path}comments/"
)

comment_summary_df = comments_df.select(
    "id",
    length("body").alias("comment_length")
)

comment_summary_df.write.mode("overwrite").parquet(
    f"{processed_path}comment_summary/"
)