module "resume_bucket_cloud_front_distribution" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.2"

  create_origin_access_identity = true
  origin_access_identities = {
    resume_s3_bucket = "OAI CloudFront to S3 Resume Bucket"
  }

  origin = {
    resume_s3_bucket = {
      domain_name = aws_s3_bucket.resume_bucket.bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "resume_s3_bucket"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "resume_s3_bucket"
    viewer_protocol_policy = "https-only"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
    min_ttl         = "${60 * 60 * 24}"
    max_ttl         = "${60 * 60 * 336}"
    default_ttl     = "${60 * 60 * 120}"
  }

  depends_on = [
    aws_s3_bucket.resume_bucket,
    aws_s3_bucket_versioning.resume_bucket_versioning,
    aws_s3_bucket_acl.resume_bucket_acl,
    aws_s3_bucket_ownership_controls.resume_bucket_ownership
  ]
}
