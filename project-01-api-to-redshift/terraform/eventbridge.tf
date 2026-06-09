resource "aws_iam_role_policy" "eventbridge_stepfunction_policy" {

  name = "eventbridge-stepfunction-policy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "states:StartExecution"
        ]

        Resource = aws_sfn_state_machine.api_pipeline.arn
      }
    ]
  })
}