# Resume Infrastructure

# Usage:
First apply CloudFront module with:
```sh
terraform apply -target=module.resume_bucket_cloud_front_distribution

```

Then apply the rest of resources:
```sh
terraform apply

```

> Note: For some reason depends_on meta argument didn't resolved correctly the dependency graph in Route53 module. TODO: Go check for it