resource "aws_iam_user" "user" {
  name          = "${local.resource_prefix.value}-user"
  force_destroy = true

  tags = {
    Name                 = "${local.resource_prefix.value}-user"
    Environment          = local.resource_prefix.value
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/iam.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "eurogig"
    git_repo             = "terragoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "cb7705f6-231b-4624-948d-3c447ec77c27"
  }

}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "userpolicy" {
  name = "excess_policy"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*",
        "s3:*",
        "lambda:*",
        "cloudwatch:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "username" {
  value = aws_iam_user.user.name
}

output "secret" {
  value = aws_iam_access_key.user.encrypted_secret
}

