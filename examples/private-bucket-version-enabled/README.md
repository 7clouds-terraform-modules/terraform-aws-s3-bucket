# 7Clouds Terraform AWS S3 Private Bucket with Versioning Enabled

## Usage

* This example creates a Private Bucket with versioning enabled and default configuration

```hcl
module "private_bucket_version_enabled" {
  source = "../.."

  PROJECT_NAME      = "NewModules"
  CONTENT_BUCKET    = "ExampleBucket7453"
  BUCKET_ACL        = "private" 
  BUCKET_VERSIONING = {
    enabled = true
  }
}
```
