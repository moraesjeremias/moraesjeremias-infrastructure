locals {
  domain_name = lookup(module.personal_hosted_zone.route53_zone_name, var.domain_name, null)
  zone_id     = lookup(module.personal_hosted_zone.route53_zone_zone_id, var.domain_name, null)
}

module "resume_acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.4.0"

  domain_name = local.domain_name
  zone_id     = local.zone_id


  subject_alternative_names = [
    "*.${local.domain_name}",
    "resume.${local.domain_name}",
  ]

  wait_for_validation = true

  tags = {
    Name      = "${local.domain_name}"
    ManagedBy = "Terraform"
  }
}
