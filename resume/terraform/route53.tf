module "personal_hosted_zone" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.6.0"

  zones = {
    "moraesjeremias.com" = {
      comment = "Jeremias' Moraes personal domain"
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = keys(module.personal_hosted_zone.route53_zone_zone_id)[0]

  records = [
    {
      name = "resume"
      type = "A"
      alias = {
        name    = module.resume_bucket_cloud_front_distribution.cloudfront_distribution_domain_name
        zone_id = module.resume_bucket_cloud_front_distribution.cloudfront_distribution_hosted_zone_id
      }
    },
  ]

  depends_on = [
    module.personal_hosted_zone,
    module.resume_bucket_cloud_front_distribution
  ]
}
