data "aws_iam_policy_document" "resume_bucket_role_policy" {
  statement {
    actions = ["s3:GetObject"]

    principals {
      type        = "AWS"
      identifiers = [module.resume_bucket_cloud_front_distribution.cloudfront_origin_access_identity_iam_arns[0]]
    }
    resources = [
      aws_s3_bucket.resume_bucket.arn,
      "${aws_s3_bucket.resume_bucket.arn}/*"
    ]

  }
}
