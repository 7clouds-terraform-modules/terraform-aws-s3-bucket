############################################################################################
#                                      LOCALS                                              #
############################################################################################
variable "LOCALS_GRANT" {
  type        = list(any)
  description = "ACL policy grant to be assigned on Locals. Conflicts with 'acl'"
  default     = []
}

variable "LOCALS_CORS_RULES" {
  type        = list(any)
  description = "List of maps containing rules for Cross-Origin Resource Sharing to be assigned on Locals"
  default     = []
}

variable "LOCALS_LIFECYCLE_RULES" {
  type        = list(any)
  description = "List of maps containing configuration of object lifecycle management to be assigned on Locals"
  default     = []
}

variable "LOCALS_INTELLIGENT_TIERING" {
  type        = list(any)
  description = "Map containing intelligent tiering configuration to be assigned on Locals"
  default     = []
}

############################################################################################
#                                      ESSENTIAL                                           #
############################################################################################
variable "PROJECT_NAME" {
  type        = string
  description = "The project name that will be prefixed to resource names"
  default     = ""
}

############################################################################################
#                                      STRUCTURAL                                          #
############################################################################################
variable "CREATE_BUCKET" {
  type        = bool
  description = "To control if S3 bucket should be created"
  default     = true
}

variable "AWS_CALLER_IDENTITY_ACCOUNT_ID" {
  type        = string
  description = "AWS Caller Identity"
  default = ""
}

variable "CONTENT_BUCKET" {
  type        = string
  description = " The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  default     = null
}

variable "CONTENT_BUCKET_FORCE_DESTROY" {
  type        = bool
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = true
}

variable "ATTACH_POLICY" {
  type        = bool
  description = "To control if an S3 bucket should have bucket policies attached"
  default     = false
}

variable "POLICY_JSON" {
  type        = string
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default     = null
}

variable "LAMBDA_FUNCTION_ARN" {
  type        = string
  description = "To control if an S3 bucket should have lambda access bucket policies attached"
  default     = null
}

variable "ECS_SERVICE_ARN" {
  type        = string
  description = "To control if an S3 bucket should have ECS Services bucket policies attached"
  default     = null
}

variable "EKS_WORKLOAD_ARN" {
  type        = string
  description = "To control if an S3 bucket should have EKS Workloads bucket policies attached"
  default     = null
}

variable "ATTACH_REQUIRE_LATEST_TLS_POLICY" {
  type        = bool
  description = "Controls if S3 bucket should require the latest version of TLS"
  default     = false
}

variable "ATTACH_ELB_LOG_DELIVERY_POLICY" {
  type        = bool
  description = "To control if S3 bucket should have ELB log delivery policy attached"
  default     = false
}

variable "ATTACH_LB_LOG_DELIVERY_POLICY" {
  type        = bool
  description = "To control if S3 bucket should have ALB/NLB log delivery policy attached"
  default     = false
}

variable "ATTACH_DENY_INSECURE_TRANSPORT_POLICY" {
  type        = bool
  description = "To control if S3 bucket should have deny non-SSL transport policy attached"
  default     = false
}

variable "ATTACH_PUBLIC_POLICY" {
  type        = bool
  description = "To controls if a user defined public bucket policy will be attached (set to 'false' to allow upstream to apply defaults to the bucket)"
  default     = true
}

variable "BLOCK_PUBLIC_ACLS" {
  type        = bool
  description = "To define wether Amazon S3 should block public ACLs for this bucket"
  default     = false
}

variable "BLOCK_PUBLIC_POLICY" {
  type        = bool
  description = "To define whether Amazon S3 should block public bucket policies for this bucket"
  default     = false
}

variable "IGNORE_PUBLIC_ACLS" {
  type        = bool
  description = "To define whether Amazon S3 should ignore public ACLs for this bucket"
  default     = false
}

variable "RESTRICT_PUBLIC_BUCKETS" {
  type        = bool
  description = "To define whether Amazon S3 should restrict public bucket policies for this bucket"
  default     = false
}

variable "BUCKET_LOGGING_ENABLED" {
  type        = bool
  description = "To indicate whether Bucket Logging will be enabled"
  default     = false
}

variable "BUCKET_LOGGING_TARGET_BUCKET" {
  type        = string
  description = "The name of the bucket where you want Amazon S3 to store server access logs"
  default     = null
}

variable "BUCKET_LOGGING_TARGET_PREFIX" {
  type        = string
  description = "The name of the bucket where you want Amazon S3 to store server access logs"
  default     = null
}

variable "BUCKET_ACL" {
  type        = string
  description = "The canned ACL to apply. Conflicts with 'grant'"
  default     = null
}

variable "WEBSITE" {
  type        = map(string)
  description = "Map containing static web-site hosting or redirect configuration."
  default     = {}
}

variable "BUCKET_VERSIONING" {
  type        = map(string)
  description = "Versioning configuration Map"
  default     = {}
}

variable "SERVER_SIDE_ENCRYPTION_CONFIGURATION" {
  type        = map(any)
  description = "Server-side encryption configuration"
  default     = {}
}

variable "PAYMENT_CONFIGURATION_REQUEST_PAYER" {
  type        = string
  description = "Specification of who should bear the cost of Amazon S3 data transfer. Accepted values are BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
  default     = null
}

variable "OBJECT_LOCK" {
  type        = bool
  description = "To define Whether S3 bucket should have an Object Lock configuration"
  default     = false
}

variable "OBJECT_LOCK_CONFIGURATION" {
  type        = map(any)
  description = "Map OF S3 object locking configuration"
  default     = {}
}

variable "REPLICATION_CONFIGURATION" {
  type        = map(any)
  description = "Map of cross-region replication configuration."
  default     = {}
}

variable "CONTROL_OBJECT_OWNERSHIP" {
  type        = bool
  description = "To define whether to manage S3 Bucket Ownership Controls on this bucket"
  default     = false
}

variable "OBJECT_OWNERSHIP" {
  type        = string
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
  default     = "ObjectWriter"
}

variable "INTELLIGENT_TIERING" {
  type        = map(any)
  description = "Map containing intelligent tiering configuration"
  default     = {}
}

variable "TAGS" {
  type        = map(string)
  description = "Tag List"
  default     = null
}

# ###########################################################################################
# #                                      OPTIONAL                                           #
# ###########################################################################################
variable "CONTENT_BUCKET_PREFIX" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length"
  default     = null
}

variable "CONTENT_BUCKET_OBJECT_LOCKED_ENABLED" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions"
  default     = null
}

variable "EXPECTED_BUCKET_OWNER" {
  description = "The account ID of the expected bucket owner. Forces new resource"
  default     = null
}

variable "ACCELERATION_CONFIGURATION_STATUS" {
  type        = string
  description = "Sets the accelerate configuration of an existing bucket. Accepted values are 'Enabled' or 'Suspended'"
  default     = null
}

