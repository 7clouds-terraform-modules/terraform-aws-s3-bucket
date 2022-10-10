module "s3_bucket_alb_policy_attached" {
  source = "../.."

  PROJECT_NAME                   = "NewModules"
  CONTENT_BUCKET                 = "example-bucket-7453"
  BUCKET_ACL                     = "log-delivery-write"
  ATTACH_POLICY                  = true
  CONTENT_BUCKET_FORCE_DESTROY   = true
  ATTACH_LB_LOG_DELIVERY_POLICY  = true
  ATTACH_ELB_LOG_DELIVERY_POLICY = true
}