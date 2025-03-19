provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  backend "local" {
    path = "./jsbase-terraform-lession003-s3-backend.tfstate"
  }
}


resource "aws_s3_bucket" "main_s3_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "jsbase-${var.environment}"
  }
}

resource "aws_iam_user" "main_user" {
  name = var.user_name
  tags = {
    Name = "jsbase-${var.environment}"
  }
}

resource "aws_iam_access_key" "main_user_access_key" {
  user = aws_iam_user.main_user.name
}

data "aws_iam_policy_document" "main_user_policy" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      aws_s3_bucket.main_s3_bucket.arn,
      "${aws_s3_bucket.main_s3_bucket.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "main_user_policy"
  description = "A main_user_policy"
  policy      = data.aws_iam_policy_document.main_user_policy.json
}

resource "aws_iam_policy_attachment" "attach_user_policy" {
  name       = "user_policy_attachment"
  users      = [aws_iam_user.main_user.name]
  policy_arn = aws_iam_policy.policy.arn
}