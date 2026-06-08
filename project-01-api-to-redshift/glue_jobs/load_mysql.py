import sys

from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.utils import getResolvedOptions

args = getResolvedOptions(
    sys.argv,
    [
        "JOB_NAME",
        "TARGET_BUCKET"
    ]
)

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
logger = glueContext.get_logger()

bucket = args["TARGET_BUCKET"]

#secret manager
mysql_url = "jdbc:mysql://<MYSQL_HOST>:3306/api_etl"
mysql_user = "root"
mysql_password = "root"

tables = {
    "users": "users",
    "user_address": "user_address",
    "posts": "posts",
    "post_summary": "post_summary",
    "comments": "comments",
    "comment_summary": "comment_summary"
}

for source_folder, target_table in tables.items():

    path = f"s3://{bucket}/processed/{source_folder}/"

    logger.info(f"Reading {path}")

    df = spark.read.parquet(path)

    logger.info(f"Rows Found: {df.count()}")

    # Column standardization

    if target_table == "posts":
        df = df.withColumnRenamed(
            "userId",
            "user_id"
        )

    if target_table == "comments":
        df = df.withColumnRenamed(
            "postId",
            "post_id"
        )

    logger.info(
        f"Loading {target_table}"
    )

    df.write \
        .format("jdbc") \
        .option("url", mysql_url) \
        .option("dbtable", target_table) \
        .option("user", mysql_user) \
        .option("password", mysql_password) \
        .option(
            "driver",
            "com.mysql.cj.jdbc.Driver"
        ) \
        .mode("append") \
        .save()

    logger.info(
        f"{target_table} loaded successfully"
    )

logger.info("All tables loaded successfully")