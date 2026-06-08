resource "aws_iam_role" "glue_role" {

  name = "${var.project_name}-glue-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "glue.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# AWS Managed Glue Policy
resource "aws_iam_role_policy_attachment" "glue_service_role" {

  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# S3 Access Policy
resource "aws_iam_policy" "glue_s3_policy" {

  name = "${var.project_name}-glue-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:*"
        ]

        Resource = [
          aws_s3_bucket.data_bucket.arn,
          "${aws_s3_bucket.data_bucket.arn}/*"
        ]
      }
    ]
  })
}

#  Attach the custom S3 policy to the Glue role:
resource "aws_iam_role_policy_attachment" "glue_s3_attach" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_s3_policy.arn
}

#IAM Role for redshift_role
resource "aws_iam_role" "redshift_role" {

  name = "redshift-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "redshift.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

#S3 policy
resource "aws_iam_policy" "redshift_s3_policy" {

  name = "redshift-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = [
          aws_s3_bucket.data_bucket.arn,
          "${aws_s3_bucket.data_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "step_function_role" {
  name = "${var.project_name}-step-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}