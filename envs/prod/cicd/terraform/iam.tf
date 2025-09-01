resource "aws_iam_user" "terraform_github" {
  name = "${local.name_prefix}-terraform-github"

  tags = {
    Name = "${local.name_prefix}-terraform-github"
  }
}

resource "aws_iam_role" "terraform_deployer" {
  name = "${local.name_prefix}-terraform-deployer"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole",
          "sts:TagSession"
        ],
        "Principal" : {
          "AWS" : aws_iam_user.terraform_github.arn
        }
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-terraform-deployer"
  }
}

resource "aws_iam_role_policy_attachment" "terraform_admin" {
  role       = aws_iam_role.terraform_deployer.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy" "terraform_iam" {
  name = "terraform-iam"
  role = aws_iam_role.terraform_deployer.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}