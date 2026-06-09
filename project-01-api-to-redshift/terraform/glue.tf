# 1st glue job
resource "aws_glue_job" "extract_api_job" {

  name     = "extract-api-job"
  role_arn = aws_iam_role.glue_role.arn

  glue_version = "4.0"

  worker_type       = "G.1X"
  number_of_workers = 2

  command {
    script_location = "s3://${aws_s3_bucket.data_bucket.bucket}/scripts/extract_api.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language" = "python"
  }

  timeout = 10
}

# 2nd glue job
resource "aws_glue_job" "transform_job" {

  name = "transform-json-parquet-job"

  role_arn = aws_iam_role.glue_role.arn

  glue_version = "4.0"

  worker_type       = "G.1X"
  number_of_workers = 2

  command {

    script_location = "s3://${aws_s3_bucket.data_bucket.bucket}/scripts/transform_json_parquet.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language" = "python"
  }

  timeout = 10
}

# Create third Glue job.
resource "aws_glue_job" "load_mysql" {

  name     = "load-mysql-job"
  role_arn = aws_iam_role.glue_role.arn

  command {
    script_location = "s3://${aws_s3_bucket.data_bucket.bucket}/scripts/load_mysql.py"
    python_version  = "3"
  }

  default_arguments = {
    "--TARGET_BUCKET" = "api-etl-project-bucket"
  }

  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = 2

}

