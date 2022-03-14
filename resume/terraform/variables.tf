variable "domain_name" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "domain_name_comments" {
  type = string
  default = "Jeremias' Moraes personal domain"
}

variable "origin_access_identity_name" {
  type = string
  default = "OAI CloudFront to S3 Resume Bucket"
}

variable "cloudfront_origin" {
  type = string
}

variable "ssl_method" {
    type = string
    default = "sni-only"
}