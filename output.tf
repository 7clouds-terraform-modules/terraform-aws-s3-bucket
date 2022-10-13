############################################################################################
#                                 REFERENCE OUTPUTS                                        #
############################################################################################
output "BUCKET_ARN" {
  description = "Bucket ARN"
  value       = var.CREATE_BUCKET ? join("", aws_s3_bucket.this.*.arn) : null
}

output "AWS_CALLER_IDENTITY_ACCOUNT_ID" {
  description = "Identity Account ID"
  value       = data.aws_caller_identity.current
}

############################################################################################
#                                      LOCALS                                              #
############################################################################################
output "LOCALS_GRANT" {
  description = "ACL policy grant to be assigned on Locals. Conflicts with 'acl'"
  value = var.LOCALS_GRANT
}

output "LOCALS_CORS_RULES" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing to be assigned on Locals"
  value = var.LOCALS_CORS_RULES
}

output "LOCALS_LIFECYCLE_RULES" {
  description = "List of maps containing configuration of object lifecycle management to be assigned on Locals"
  value = var.LOCALS_LIFECYCLE_RULES
}

output "LOCALS_INTELLIGENT_TIERING" {
  description = "Map containing intelligent tiering configuration to be assigned on Locals"
  value = var.LOCALS_INTELLIGENT_TIERING
}

############################################################################################
#                                      ESSENTIAL                                           #
############################################################################################
output "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names"
  value = var.PROJECT_NAME
}

############################################################################################
#                                      STRUCTURAL                                          #
############################################################################################
output "CREATE_BUCKET" {
  description = "To control if S3 bucket should be created"
  value = var.CREATE_BUCKET
}

output "CONTENT_BUCKET" {
  description = " The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  value = var.CONTENT_BUCKET
}

output "CONTENT_BUCKET_FORCE_DESTROY" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  value = var.CONTENT_BUCKET_FORCE_DESTROY
}

output "ATTACH_POLICY" {
  description = "To control if an S3 bucket should have bucket policies attached"
  value = var.ATTACH_POLICY
}

output "POLICY_JSON" {
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  value = var.POLICY_JSON
}

output "LAMBDA_FUNCTION_ARN" {
  description = "To control if an S3 bucket should have lambda access bucket policies attached"
  value = var.LAMBDA_FUNCTION_ARN
}

output "ECS_SERVICE_ARN" {
  description = "To control if an S3 bucket should have ECS Services bucket policies attached"
  value = var.ECS_SERVICE_ARN
}

output "EKS_WORKLOAD_ARN" {
  description = "To control if an S3 bucket should have EKS Workloads bucket policies attached"
  value = var.EKS_WORKLOAD_ARN
}

output "ATTACH_REQUIRE_LATEST_TLS_POLICY" {
  description = "Controls if S3 bucket should require the latest version of TLS"
  value = var.ATTACH_REQUIRE_LATEST_TLS_POLICY
}

output "ATTACH_ELB_LOG_DELIVERY_POLICY" {
  description = "To control if S3 bucket should have ELB log delivery policy attached"
  value = var.ATTACH_ELB_LOG_DELIVERY_POLICY
}

output "ATTACH_LB_LOG_DELIVERY_POLICY" {
  description = "To control if S3 bucket should have ALB/NLB log delivery policy attached"
  value = var.ATTACH_LB_LOG_DELIVERY_POLICY
}

output "ATTACH_DENY_INSECURE_TRANSPORT_POLICY" {
  description = "To control if S3 bucket should have deny non-SSL transport policy attached"
  value = var.ATTACH_DENY_INSECURE_TRANSPORT_POLICY
}

output "ATTACH_PUBLIC_POLICY" {
  description = "To controls if a user defined public bucket policy will be attached (set to 'false' to allow upstream to apply defaults to the bucket)"
  value = var.ATTACH_PUBLIC_POLICY
}

output "BLOCK_PUBLIC_ACLS" {
  description = "To define wether Amazon S3 should block public ACLs for this bucket"
  value = var.BLOCK_PUBLIC_ACLS
}

output "BLOCK_PUBLIC_POLICY" {
  description = "To define whether Amazon S3 should block public bucket policies for this bucket"
  value = var.BLOCK_PUBLIC_POLICY
}

output "IGNORE_PUBLIC_ACLS" {
  description = "To define whether Amazon S3 should ignore public ACLs for this bucket"
  value = var.IGNORE_PUBLIC_ACLS
}

output "RESTRICT_PUBLIC_BUCKETS" {
  description = "To define whether Amazon S3 should restrict public bucket policies for this bucket"
  value = var.RESTRICT_PUBLIC_BUCKETS
}

output "BUCKET_LOGGING_ENABLED" {
  description = "To indicate whether Bucket Logging will be enabled"
  value = var.BUCKET_LOGGING_ENABLED
}

output "BUCKET_LOGGING_TARGET_BUCKET" {
  description = "The name of the bucket where you want Amazon S3 to store server access logs"
  value = var.BUCKET_LOGGING_TARGET_BUCKET
}

output "BUCKET_LOGGING_TARGET_PREFIX" {
  description = "The name of the bucket where you want Amazon S3 to store server access logs"
  value = var.BUCKET_LOGGING_TARGET_PREFIX
}

output "BUCKET_ACL" {
  description = "The canned ACL to apply. Conflicts with 'grant'"
  value = var.BUCKET_ACL
}

output "WEBSITE" {
  description = "Map containing static web-site hosting or redirect configuration."
  value = var.WEBSITE
}

output "BUCKET_VERSIONING" {
  description = "Versioning configuration Map"
  value = var.BUCKET_VERSIONING
}

output "SERVER_SIDE_ENCRYPTION_CONFIGURATION" {
  description = "Server-side encryption configuration"
  value = var.SERVER_SIDE_ENCRYPTION_CONFIGURATION
}

output "PAYMENT_CONFIGURATION_REQUEST_PAYER" {
  description = "Specification of who should bear the cost of Amazon S3 data transfer. Accepted values are BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
  value = var.PAYMENT_CONFIGURATION_REQUEST_PAYER
}

output "OBJECT_LOCK" {
  description = "To define Whether S3 bucket should have an Object Lock configuration"
  value = var.OBJECT_LOCK
}

output "OBJECT_LOCK_CONFIGURATION" {
  description = "Map OF S3 object locking configuration"
  value = var.OBJECT_LOCK_CONFIGURATION
}

output "REPLICATION_CONFIGURATION" {
  description = "Map of cross-region replication configuration."
  value = var.REPLICATION_CONFIGURATION
}

output "CONTROL_OBJECT_OWNERSHIP" {
  description = "To define whether to manage S3 Bucket Ownership Controls on this bucket"
  value = var.CONTROL_OBJECT_OWNERSHIP
}

output "OBJECT_OWNERSHIP" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
  value = var.OBJECT_OWNERSHIP
}

output "INTELLIGENT_TIERING" {
  description = "Map containing intelligent tiering configuration"
  value = var.INTELLIGENT_TIERING
}

output "TAGS" {
  description = "Tag List"
  value = var.TAGS
}

# ###########################################################################################
# #                                      OPTIONAL                                           #
# ###########################################################################################
output "CONTENT_BUCKET_PREFIX" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length"
  value = var.CONTENT_BUCKET_PREFIX
}

output "CONTENT_BUCKET_OBJECT_LOCKED_ENABLED" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions"
  value = var.CONTENT_BUCKET_OBJECT_LOCKED_ENABLED
}

output "EXPECTED_BUCKET_OWNER" {
  description = "The account ID of the expected bucket owner. Forces new resource"
  value = var.EXPECTED_BUCKET_OWNER
}

output "ACCELERATION_CONFIGURATION_STATUS" {
  description = "Sets the accelerate configuration of an existing bucket. Accepted values are 'Enabled' or 'Suspended'"
  value = var.ACCELERATION_CONFIGURATION_STATUS
}

