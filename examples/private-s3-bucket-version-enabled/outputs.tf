output "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  value = module.private_bucket_version_enabled.PROJECT_NAME
}

output "CONTENT_BUCKET" {
  description = " The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  value = module.private_bucket_version_enabled.CONTENT_BUCKET
}

output "BUCKET_ACL" {
  description = "The canned ACL to apply. Conflicts with 'grant'"
  value = module.private_bucket_version_enabled.BUCKET_ACL
}

output "BUCKET_VERSIONING" {
  description = "Versioning configuration Map"
  value = module.private_bucket_version_enabled.BUCKET_VERSIONING
}