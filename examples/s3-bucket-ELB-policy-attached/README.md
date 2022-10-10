# 7Clouds Terraform AWS S3 Bucket with ELB Policy and Logging

## Usage

* This example creates a Bucket with Elastic Load Balancer policy and logs delivery configuration for acl

```hcl
module "s3_bucket_elb_policy_attached" {
  source = "../.."

  PROJECT_NAME                   = "NewModules"
  CONTENT_BUCKET                 = "example-bucket-7453"
  BUCKET_ACL                     = "log-delivery-write"
  ATTACH_POLICY                  = true
  CONTENT_BUCKET_FORCE_DESTROY   = true
  ATTACH_ELB_LOG_DELIVERY_POLICY = true
}
```
