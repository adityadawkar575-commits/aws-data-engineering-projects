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

resource "aws_glue_job" "transform_job" {

  name     = "transform-json-parquet-job"

  role_arn = aws_iam_role.glue_role.arn

  glue_version = "4.0"

  worker_type       = "G.1X"
  number_of_workers = 2

  command {

    script_location = "s3://${aws_s3_bucket.data_bucket.bucket}/scripts/transform_json_parquet.py"
    python_version = "3"
  }

  default_arguments = {
    "--job-language" = "python"
  }

  timeout = 10
}

