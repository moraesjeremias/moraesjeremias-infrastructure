module "resume_bucket_cloud_front_distribution" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.2"

  create_origin_access_identity = true
  origin_access_identities = {
    (var.cloudfront_origin) = var.origin_access_identity_name
  }

  origin = {
    (var.cloudfront_origin) = {
      domain_name = aws_s3_bucket.resume_bucket.bucket_domain_name
      s3_origin_config = {
        origin_access_identity = var.cloudfront_origin
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = var.cloudfront_origin
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
    min_ttl         = "${60 * 60 * 24}"
    max_ttl         = "${60 * 60 * 336}"
    default_ttl     = "${60 * 60 * 120}"
  }

    viewer_certificate = {
    acm_certificate_arn = module.resume_acm.acm_certificate_arn
    ssl_support_method  = var.ssl_method
  }

  depends_on = [
    aws_s3_bucket.resume_bucket,
  ]
}
