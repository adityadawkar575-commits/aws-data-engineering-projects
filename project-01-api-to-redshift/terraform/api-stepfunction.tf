resource "aws_sfn_state_machine" "api_pipeline" {

  name     = "api-etl-pipeline"
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    StartAt = "ExtractAPI"

    States = {

      ExtractAPI = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"

        Parameters = {
          JobName = aws_glue_job.extract_api_job.name
        }

        Next = "TransformData"
      }

      TransformData = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"

        Parameters = {
          JobName = aws_glue_job.transform_job.name
        }

        Next = "LoadMySQL"
      }

      LoadMySQL = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"

        Parameters = {
          JobName = aws_glue_job.load_mysql.name
        }

        End = true
      }
    }
  })
}

#6. EVENTBRIDGE RULE - Creates a scheduler. Automatically triggers pipeline.
resource "aws_cloudwatch_event_rule" "daily_run" {

  name                = "api-etl-daily"
  schedule_expression = "cron(0 2 * * ? *)"
}

resource "aws_cloudwatch_event_target" "step_function_target" {
  rule     = aws_cloudwatch_event_rule.daily_run.name
  arn      = aws_sfn_state_machine.api_pipeline.arn
  role_arn = aws_iam_role.eventbridge_role.arn
}