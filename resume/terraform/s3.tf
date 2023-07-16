resource "aws_s3_bucket" "resume_bucket" {
  bucket = "resume-jeremias-moraes"
  tags = {
    "name" = "resume"
  }
  tags_all = {
    "name" = "resume"
  }
}

resource "aws_s3_bucket_versioning" "resume_bucket_versioning" {
  bucket = aws_s3_bucket.resume_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "resume_bucket_acl" {
  bucket = aws_s3_bucket.resume_bucket.id
  acl    = "private"

}

resource "aws_s3_bucket_ownership_controls" "resume_bucket_ownership" {
  bucket = aws_s3_bucket.resume_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_public" {
  bucket = aws_s3_bucket.resume_bucket.id
  policy = data.aws_iam_policy_document.resume_bucket_role_policy.json
  depends_on = [
    module.resume_bucket_cloud_front_distribution
  ]
}

resource "aws_s3_bucket_public_access_block" "block_public_policy" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls   = true
  block_public_policy = true
}