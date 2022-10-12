module "private_bucket_version_enabled" {
  source = "../.."

  PROJECT_NAME                          = "NewModules"
  CONTENT_BUCKET                        = "example-bucket-7453"
  BUCKET_ACL                            = "private" 
  BUCKET_VERSIONING                     = {
    enabled = true
  }
}