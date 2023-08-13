# IAM role to be assumed
resource "aws_iam_role" "cloudtrail-roles" {
  name = "${var.environment}-${var.project}-cloudtrail-roles"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF

  tags = {
    name = "${var.environment}-${var.project}-cloudtrail-roles"
  }
}


resource "aws_iam_policy" "cloudtrail-policy" {
  name        = "${var.environment}-${var.project}-trail-policy-for-log-groups"
  description = "policy for trail to send events to cloudwatch log groups"
  path        = "/"
  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream"
            ],
            "Resource": [
              "${aws_cloudwatch_log_group.log-group.arn}:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
              "${aws_cloudwatch_log_group.log-group.arn}:*"
            ]
        }
      ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudtrail-roles-policies" {
  role       = aws_iam_role.cloudtrail-roles.name
  policy_arn = aws_iam_policy.cloudtrail-policy.arn
}