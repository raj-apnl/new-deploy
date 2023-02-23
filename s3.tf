resource "random_string" "test_suffix" {
  length           = 3
  special          = false
  override_special = "-"
  upper            = false
}

module "s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "~> 3.4.0"
  bucket        = "cpuc-cloudfront-static-bucket-${random_string.test_suffix.id}"
  force_destroy = true
  acl           = "private"
  attach_policy = true
  policy        = data.aws_iam_policy_document.this.json

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    status     = true
    mfa_delete = false
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "cpuc-Terraform-s3-Bucket"
    Environment = "dev"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:GetObjectACL"
    ]

    resources = [
      module.s3_bucket.s3_bucket_arn,
      "${module.s3_bucket.s3_bucket_arn}/*",
    ]
    effect = "Allow"
  }
}

