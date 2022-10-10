output "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  value = module.s3_bucket_elb_policy_attached.PROJECT_NAME
}

output "CONTENT_BUCKET" {
  description = " The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  value = module.s3_bucket_elb_policy_attached.CONTENT_BUCKET
}

output "BUCKET_ACL" {
  description = "The canned ACL to apply. Conflicts with 'grant'"
  value = module.s3_bucket_elb_policy_attached.BUCKET_ACL
}

output "ATTACH_ELB_LOG_DELIVERY_POLICY" {
  description = "Versioning configuration Map"
  value = module.s3_bucket_elb_policy_attached.ATTACH_ELB_LOG_DELIVERY_POLICY
}

output "ATTACH_POLICY" {
  description = "Versioning configuration Map"
  value = module.s3_bucket_elb_policy_attached.ATTACH_POLICY
}