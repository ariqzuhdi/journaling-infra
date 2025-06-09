resource "aws_iam_role_policy_attachment" "cloudwatch_ec2_policy_attachment" {
  role       = aws_iam_role.cloudwatch_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# resource "aws_iam_policy" "ecr_cloudtrail_policy" {
#   name        = "ecr-cloudtrail-policy"
#   description = "Allow ECR access and CloudTrail lookup"
#   policy      = file("/policies/ecr_cloudtrail_policy.json")
# }

# resource "aws_iam_role_policy_attachment" "ecr_cloudtrail_attach" {
#   role       = aws_iam_role.journaling_instance_role.name
#   policy_arn = aws_iam_policy.ecr_cloudtrail_policy.arn
# }

resource "aws_iam_policy" "ssm_parameter" {
  name        = "AllowSSMParameter"
  description = "Allow EC2 role to get/put parameter from SSM Parameter Store and describe instances"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:PutParameter"
        ],
        Resource = "arn:aws:ssm:ap-southeast-1:339712978316:parameter/AmazonCloudWatch-linux"
      },
      {
        Effect   = "Allow",
        Action   = "ec2:DescribeInstances",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "attach_ssm_policy" {
  name       = "attach-ssm-parameter"
  policy_arn = aws_iam_policy.ssm_parameter.arn
  roles      = [aws_iam_role.accessall.name]
}


resource "aws_iam_instance_profile" "journaling_profile" {
  name = "accessall"
  role = aws_iam_role.accessall.name
}
