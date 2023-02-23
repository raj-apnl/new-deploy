
data "archive_file" "hello_world" {
  type        = "zip"
  source_file = "${path.module}/hello_world.py"
  output_path = "outputs/hello_world.zip"
}

# GET LAMBDA 
resource "aws_lambda_function" "hello_world" {
  filename      = "outputs/hello_world.zip"
  function_name = "cpuc-api-hello_world"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "hello_world.test"
  runtime       = "python3.7"

}

resource "aws_iam_role" "lambda_exec" {
  name = "hello_world_lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}
