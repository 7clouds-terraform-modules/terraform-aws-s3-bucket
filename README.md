# S3 Bucket Module by 7Clouds

Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%! Check it out at <https://seventechnologies.cloud>

Please rank this repo 5 starts if you like our job!

## Usage

Our S3 Bucket Module encompasses settings for versioning, encryption, policies attachment, force destroy and acl configuration. Each resource/data has conditions applied on their count arguments, in a way that setting/overriding the variables is enough to serve your needs

```hcl
module "contentmanagement" {
  source = "./s3contentmanagementmodule"
  # Essential
  PROJECT_NAME = "NewModules"

  # Locals
  # LOCALS_GRANT = []
  # LOCALS_CORS_RULES = []
  # LOCALS_LIFECYCLE_RULES = []
  # LOCALS_INTELLIGENT_TIERING = []

  # Structural
  # AWS_CALLER_IDENTITY_ACCOUNT_ID       = module.lambdaapigateway.AWS_CALLER_IDENTITY_ACCOUNT_ID
  CREATE_BUCKET                         = true
  CONTENT_BUCKET                        = "ExampleBucket7453"
  CONTENT_BUCKET_FORCE_DESTROY          = true
  ATTACH_POLICY                         = false
  POLICY_JSON                           = ""
  LAMBDA_FUNCTION_ARN                   = null
  ECS_SERVICE_ARN                       = null
  EKS_WORKLOAD_ARN                      = null
  ATTACH_REQUIRE_LATEST_TLS_POLICY      = false
  ATTACH_ELB_LOG_DELIVERY_POLICY        = false
  ATTACH_LB_LOG_DELIVERY_POLICY         = false
  ATTACH_DENY_INSECURE_TRANSPORT_POLICY = false
  ATTACH_PUBLIC_POLICY                  = false
  BLOCK_PUBLIC_ACLS                     = false
  BLOCK_PUBLIC_POLICY                   = false
  IGNORE_PUBLIC_ACLS                    = false
  RESTRICT_PUBLIC_BUCKETS               = false
  # BUCKET_LOGGING_ENABLED               = true # If true, BUCKET_LOGGING_TARGET_BUCKET and BUCKET_LOGGING_TARGET_PREFIX must be set
  # BUCKET_LOGGING_TARGET_BUCKET         = "AnotherExampleBucket564"
  # BUCKET_LOGGING_TARGET_PREFIX         = ""
  # WEBSITE                              = {}
  # BUCKET_VERSIONING                    = {}
  # SERVER_SIDE_ENCRYPTION_CONFIGURATION = {}
  # PAYMENT_CONFIGURATION_REQUEST_PAYER  = null
  OBJECT_LOCK                           = false
  # OBJECT_LOCK_CONFIGURATION            = {}
  # REPLICATION_CONFIGURATION            = {}
  CONTROL_OBJECT_OWNERSHIP              = false
  OBJECT_OWNERSHIP                      = ""
  # INTELLIGENT_TIERING                  = {}
  # TAGS                                 = module.tags.TAGS
  # Optional
  CONTENT_BUCKET_PREFIX                 = null
  CONTENT_BUCKET_OBJECT_LOCKED_ENABLED  = null
  EXPECTED_BUCKET_OWNER                 = null
  ACCELERATION_CONFIGURATION_STATUS     = null
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

</br>

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

| Name | Source | Version |
|------|--------|---------|
| <a name="terraform-aws-s3-bucket"></a> [terraform-aws-s3-bucket](#module\_private\_bucket\_version\_enabled) | ../.. | 0.1.0 |

</br>

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_accelerate_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_accelerate_configuration) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_cors_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_object_lock_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_request_payment_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_request_payment_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_elb_service_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_iam_policy_document.allow_ecs_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_eks_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_lambda_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deny_insecure_transport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elb_log_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lb_log_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.require_latest_tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

</br>

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACCELERATION_CONFIGURATION_STATUS"></a> [ACCELERATION\_CONFIGURATION\_STATUS](#input\_ACCELERATION\_CONFIGURATION\_STATUS) | Sets the accelerate configuration of an existing bucket. Accepted values are 'Enabled' or 'Suspended' | `string` | `null` | no |
| <a name="input_ATTACH_DENY_INSECURE_TRANSPORT_POLICY"></a> [ATTACH\_DENY\_INSECURE\_TRANSPORT\_POLICY](#input\_ATTACH\_DENY\_INSECURE\_TRANSPORT\_POLICY) | To control if S3 bucket should have deny non-SSL transport policy attached | `bool` | `false` | no |
| <a name="input_ATTACH_ELB_LOG_DELIVERY_POLICY"></a> [ATTACH\_ELB\_LOG\_DELIVERY\_POLICY](#input\_ATTACH\_ELB\_LOG\_DELIVERY\_POLICY) | To control if S3 bucket should have ELB log delivery policy attached | `bool` | `false` | no |
| <a name="input_ATTACH_LB_LOG_DELIVERY_POLICY"></a> [ATTACH\_LB\_LOG\_DELIVERY\_POLICY](#input\_ATTACH\_LB\_LOG\_DELIVERY\_POLICY) | To control if S3 bucket should have ALB/NLB log delivery policy attached | `bool` | `false` | no |
| <a name="input_ATTACH_POLICY"></a> [ATTACH\_POLICY](#input\_ATTACH\_POLICY) | To control if an S3 bucket should have bucket policies attached | `bool` | `false` | no |
| <a name="input_ATTACH_PUBLIC_POLICY"></a> [ATTACH\_PUBLIC\_POLICY](#input\_ATTACH\_PUBLIC\_POLICY) | To controls if a user defined public bucket policy will be attached (set to 'false' to allow upstream to apply defaults to the bucket) | `bool` | `true` | no |
| <a name="input_ATTACH_REQUIRE_LATEST_TLS_POLICY"></a> [ATTACH\_REQUIRE\_LATEST\_TLS\_POLICY](#input\_ATTACH\_REQUIRE\_LATEST\_TLS\_POLICY) | Controls if S3 bucket should require the latest version of TLS | `bool` | `false` | no |
| <a name="input_AWS_CALLER_IDENTITY_ACCOUNT_ID"></a> [AWS\_CALLER\_IDENTITY\_ACCOUNT\_ID](#input\_AWS\_CALLER\_IDENTITY\_ACCOUNT\_ID) | AWS Caller Identity | `any` | `""` | no |
| <a name="input_BLOCK_PUBLIC_ACLS"></a> [BLOCK\_PUBLIC\_ACLS](#input\_BLOCK\_PUBLIC\_ACLS) | To define wether Amazon S3 should block public ACLs for this bucket | `bool` | `false` | no |
| <a name="input_BLOCK_PUBLIC_POLICY"></a> [BLOCK\_PUBLIC\_POLICY](#input\_BLOCK\_PUBLIC\_POLICY) | To define whether Amazon S3 should block public bucket policies for this bucket | `bool` | `false` | no |
| <a name="input_BUCKET_ACL"></a> [BUCKET\_ACL](#input\_BUCKET\_ACL) | The canned ACL to apply. Conflicts with 'grant' | `string` | `null` | no |
| <a name="input_BUCKET_LOGGING_ENABLED"></a> [BUCKET\_LOGGING\_ENABLED](#input\_BUCKET\_LOGGING\_ENABLED) | To indicate whether Bucket Logging will be enabled | `bool` | `false` | no |
| <a name="input_BUCKET_LOGGING_TARGET_BUCKET"></a> [BUCKET\_LOGGING\_TARGET\_BUCKET](#input\_BUCKET\_LOGGING\_TARGET\_BUCKET) | The name of the bucket where you want Amazon S3 to store server access logs | `string` | `null` | no |
| <a name="input_BUCKET_LOGGING_TARGET_PREFIX"></a> [BUCKET\_LOGGING\_TARGET\_PREFIX](#input\_BUCKET\_LOGGING\_TARGET\_PREFIX) | The name of the bucket where you want Amazon S3 to store server access logs | `string` | `null` | no |
| <a name="input_BUCKET_VERSIONING"></a> [BUCKET\_VERSIONING](#input\_BUCKET\_VERSIONING) | Versioning configuration Map | `map(string)` | `{}` | no |
| <a name="input_CONTENT_BUCKET"></a> [CONTENT\_BUCKET](#input\_CONTENT\_BUCKET) | The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length | `string` | `null` | no |
| <a name="input_CONTENT_BUCKET_FORCE_DESTROY"></a> [CONTENT\_BUCKET\_FORCE\_DESTROY](#input\_CONTENT\_BUCKET\_FORCE\_DESTROY) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `true` | no |
| <a name="input_CONTENT_BUCKET_OBJECT_LOCKED_ENABLED"></a> [CONTENT\_BUCKET\_OBJECT\_LOCKED\_ENABLED](#input\_CONTENT\_BUCKET\_OBJECT\_LOCKED\_ENABLED) | Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions | `any` | `null` | no |
| <a name="input_CONTENT_BUCKET_PREFIX"></a> [CONTENT\_BUCKET\_PREFIX](#input\_CONTENT\_BUCKET\_PREFIX) | Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length | `any` | `null` | no |
| <a name="input_CONTROL_OBJECT_OWNERSHIP"></a> [CONTROL\_OBJECT\_OWNERSHIP](#input\_CONTROL\_OBJECT\_OWNERSHIP) | To define whether to manage S3 Bucket Ownership Controls on this bucket | `bool` | `false` | no |
| <a name="input_CREATE_BUCKET"></a> [CREATE\_BUCKET](#input\_CREATE\_BUCKET) | To control if S3 bucket should be created | `bool` | `true` | no |
| <a name="input_ECS_SERVICE_ARN"></a> [ECS\_SERVICE\_ARN](#input\_ECS\_SERVICE\_ARN) | To control if an S3 bucket should have ECS Services bucket policies attached | `string` | `null` | no |
| <a name="input_EKS_WORKLOAD_ARN"></a> [EKS\_WORKLOAD\_ARN](#input\_EKS\_WORKLOAD\_ARN) | To control if an S3 bucket should have EKS Workloads bucket policies attached | `string` | `null` | no |
| <a name="input_EXPECTED_BUCKET_OWNER"></a> [EXPECTED\_BUCKET\_OWNER](#input\_EXPECTED\_BUCKET\_OWNER) | The account ID of the expected bucket owner. Forces new resource | `any` | `null` | no |
| <a name="input_IGNORE_PUBLIC_ACLS"></a> [IGNORE\_PUBLIC\_ACLS](#input\_IGNORE\_PUBLIC\_ACLS) | To define whether Amazon S3 should ignore public ACLs for this bucket | `bool` | `false` | no |
| <a name="input_INTELLIGENT_TIERING"></a> [INTELLIGENT\_TIERING](#input\_INTELLIGENT\_TIERING) | Map containing intelligent tiering configuration | `any` | `{}` | no |
| <a name="input_LAMBDA_FUNCTION_ARN"></a> [LAMBDA\_FUNCTION\_ARN](#input\_LAMBDA\_FUNCTION\_ARN) | To control if an S3 bucket should have lambda access bucket policies attached | `string` | `null` | no |
| <a name="input_LOCALS_CORS_RULES"></a> [LOCALS\_CORS\_RULES](#input\_LOCALS\_CORS\_RULES) | List of maps containing rules for Cross-Origin Resource Sharing to be assigned on Locals | `any` | `[]` | no |
| <a name="input_LOCALS_GRANT"></a> [LOCALS\_GRANT](#input\_LOCALS\_GRANT) | ACL policy grant to be assigned on Locals. Conflicts with 'acl' | `any` | `[]` | no |
| <a name="input_LOCALS_INTELLIGENT_TIERING"></a> [LOCALS\_INTELLIGENT\_TIERING](#input\_LOCALS\_INTELLIGENT\_TIERING) | Map containing intelligent tiering configuration to be assigned on Locals | `any` | `[]` | no |
| <a name="input_LOCALS_LIFECYCLE_RULES"></a> [LOCALS\_LIFECYCLE\_RULES](#input\_LOCALS\_LIFECYCLE\_RULES) | List of maps containing configuration of object lifecycle management to be assigned on Locals | `any` | `[]` | no |
| <a name="input_OBJECT_LOCK"></a> [OBJECT\_LOCK](#input\_OBJECT\_LOCK) | To define Whether S3 bucket should have an Object Lock configuration | `bool` | `false` | no |
| <a name="input_OBJECT_LOCK_CONFIGURATION"></a> [OBJECT\_LOCK\_CONFIGURATION](#input\_OBJECT\_LOCK\_CONFIGURATION) | Map OF S3 object locking configuration | `any` | `{}` | no |
| <a name="input_OBJECT_OWNERSHIP"></a> [OBJECT\_OWNERSHIP](#input\_OBJECT\_OWNERSHIP) | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL. | `string` | `"ObjectWriter"` | no |
| <a name="input_PAYMENT_CONFIGURATION_REQUEST_PAYER"></a> [PAYMENT\_CONFIGURATION\_REQUEST\_PAYER](#input\_PAYMENT\_CONFIGURATION\_REQUEST\_PAYER) | Specification of who should bear the cost of Amazon S3 data transfer. Accepted values are BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information. | `string` | `null` | no |
| <a name="input_POLICY_JSON"></a> [POLICY\_JSON](#input\_POLICY\_JSON) | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. | `string` | `null` | no |
| <a name="input_PROJECT_NAME"></a> [PROJECT\_NAME](#input\_PROJECT\_NAME) | The project name that will be prefixed to resource names | `string` | `""` | no |
| <a name="input_REPLICATION_CONFIGURATION"></a> [REPLICATION\_CONFIGURATION](#input\_REPLICATION\_CONFIGURATION) | Map of cross-region replication configuration. | `any` | `{}` | no |
| <a name="input_RESTRICT_PUBLIC_BUCKETS"></a> [RESTRICT\_PUBLIC\_BUCKETS](#input\_RESTRICT\_PUBLIC\_BUCKETS) | To define whether Amazon S3 should restrict public bucket policies for this bucket | `bool` | `false` | no |
| <a name="input_SERVER_SIDE_ENCRYPTION_CONFIGURATION"></a> [SERVER\_SIDE\_ENCRYPTION\_CONFIGURATION](#input\_SERVER\_SIDE\_ENCRYPTION\_CONFIGURATION) | Server-side encryption configuration | `any` | `{}` | no |
| <a name="input_TAGS"></a> [TAGS](#input\_TAGS) | Tag List | `map(string)` | `null` | no |
| <a name="input_WEBSITE"></a> [WEBSITE](#input\_WEBSITE) | Map containing static web-site hosting or redirect configuration. | `map(string)` | `{}` | no |

</br>

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ACCELERATION_CONFIGURATION_STATUS"></a> [ACCELERATION\_CONFIGURATION\_STATUS](#output\_ACCELERATION\_CONFIGURATION\_STATUS) | Sets the accelerate configuration of an existing bucket. Accepted values are 'Enabled' or 'Suspended' |
| <a name="output_ATTACH_DENY_INSECURE_TRANSPORT_POLICY"></a> [ATTACH\_DENY\_INSECURE\_TRANSPORT\_POLICY](#output\_ATTACH\_DENY\_INSECURE\_TRANSPORT\_POLICY) | To control if S3 bucket should have deny non-SSL transport policy attached |
| <a name="output_ATTACH_ELB_LOG_DELIVERY_POLICY"></a> [ATTACH\_ELB\_LOG\_DELIVERY\_POLICY](#output\_ATTACH\_ELB\_LOG\_DELIVERY\_POLICY) | To control if S3 bucket should have ELB log delivery policy attached |
| <a name="output_ATTACH_LB_LOG_DELIVERY_POLICY"></a> [ATTACH\_LB\_LOG\_DELIVERY\_POLICY](#output\_ATTACH\_LB\_LOG\_DELIVERY\_POLICY) | To control if S3 bucket should have ALB/NLB log delivery policy attached |
| <a name="output_ATTACH_POLICY"></a> [ATTACH\_POLICY](#output\_ATTACH\_POLICY) | To control if an S3 bucket should have bucket policies attached |
| <a name="output_ATTACH_PUBLIC_POLICY"></a> [ATTACH\_PUBLIC\_POLICY](#output\_ATTACH\_PUBLIC\_POLICY) | To controls if a user defined public bucket policy will be attached (set to 'false' to allow upstream to apply defaults to the bucket) |
| <a name="output_ATTACH_REQUIRE_LATEST_TLS_POLICY"></a> [ATTACH\_REQUIRE\_LATEST\_TLS\_POLICY](#output\_ATTACH\_REQUIRE\_LATEST\_TLS\_POLICY) | Controls if S3 bucket should require the latest version of TLS |
| <a name="output_AWS_CALLER_IDENTITY_ACCOUNT_ID"></a> [AWS\_CALLER\_IDENTITY\_ACCOUNT\_ID](#output\_AWS\_CALLER\_IDENTITY\_ACCOUNT\_ID) | Identity Account ID |
| <a name="output_BLOCK_PUBLIC_ACLS"></a> [BLOCK\_PUBLIC\_ACLS](#output\_BLOCK\_PUBLIC\_ACLS) | To define wether Amazon S3 should block public ACLs for this bucket |
| <a name="output_BLOCK_PUBLIC_POLICY"></a> [BLOCK\_PUBLIC\_POLICY](#output\_BLOCK\_PUBLIC\_POLICY) | To define whether Amazon S3 should block public bucket policies for this bucket |
| <a name="output_BUCKET_ACL"></a> [BUCKET\_ACL](#output\_BUCKET\_ACL) | The canned ACL to apply. Conflicts with 'grant' |
| <a name="output_BUCKET_ARN"></a> [BUCKET\_ARN](#output\_BUCKET\_ARN) | Bucket ARN |
| <a name="output_BUCKET_LOGGING_ENABLED"></a> [BUCKET\_LOGGING\_ENABLED](#output\_BUCKET\_LOGGING\_ENABLED) | To indicate whether Bucket Logging will be enabled |
| <a name="output_BUCKET_LOGGING_TARGET_BUCKET"></a> [BUCKET\_LOGGING\_TARGET\_BUCKET](#output\_BUCKET\_LOGGING\_TARGET\_BUCKET) | The name of the bucket where you want Amazon S3 to store server access logs |
| <a name="output_BUCKET_LOGGING_TARGET_PREFIX"></a> [BUCKET\_LOGGING\_TARGET\_PREFIX](#output\_BUCKET\_LOGGING\_TARGET\_PREFIX) | The name of the bucket where you want Amazon S3 to store server access logs |
| <a name="output_BUCKET_VERSIONING"></a> [BUCKET\_VERSIONING](#output\_BUCKET\_VERSIONING) | Versioning configuration Map |
| <a name="output_CONTENT_BUCKET"></a> [CONTENT\_BUCKET](#output\_CONTENT\_BUCKET) | The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length |
| <a name="output_CONTENT_BUCKET_FORCE_DESTROY"></a> [CONTENT\_BUCKET\_FORCE\_DESTROY](#output\_CONTENT\_BUCKET\_FORCE\_DESTROY) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. |
| <a name="output_CONTENT_BUCKET_OBJECT_LOCKED_ENABLED"></a> [CONTENT\_BUCKET\_OBJECT\_LOCKED\_ENABLED](#output\_CONTENT\_BUCKET\_OBJECT\_LOCKED\_ENABLED) | Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions |
| <a name="output_CONTENT_BUCKET_PREFIX"></a> [CONTENT\_BUCKET\_PREFIX](#output\_CONTENT\_BUCKET\_PREFIX) | Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length |
| <a name="output_CONTROL_OBJECT_OWNERSHIP"></a> [CONTROL\_OBJECT\_OWNERSHIP](#output\_CONTROL\_OBJECT\_OWNERSHIP) | To define whether to manage S3 Bucket Ownership Controls on this bucket |
| <a name="output_CREATE_BUCKET"></a> [CREATE\_BUCKET](#output\_CREATE\_BUCKET) | To control if S3 bucket should be created |
| <a name="output_ECS_SERVICE_ARN"></a> [ECS\_SERVICE\_ARN](#output\_ECS\_SERVICE\_ARN) | To control if an S3 bucket should have ECS Services bucket policies attached |
| <a name="output_EKS_WORKLOAD_ARN"></a> [EKS\_WORKLOAD\_ARN](#output\_EKS\_WORKLOAD\_ARN) | To control if an S3 bucket should have EKS Workloads bucket policies attached |
| <a name="output_EXPECTED_BUCKET_OWNER"></a> [EXPECTED\_BUCKET\_OWNER](#output\_EXPECTED\_BUCKET\_OWNER) | The account ID of the expected bucket owner. Forces new resource |
| <a name="output_IGNORE_PUBLIC_ACLS"></a> [IGNORE\_PUBLIC\_ACLS](#output\_IGNORE\_PUBLIC\_ACLS) | To define whether Amazon S3 should ignore public ACLs for this bucket |
| <a name="output_INTELLIGENT_TIERING"></a> [INTELLIGENT\_TIERING](#output\_INTELLIGENT\_TIERING) | Map containing intelligent tiering configuration |
| <a name="output_LAMBDA_FUNCTION_ARN"></a> [LAMBDA\_FUNCTION\_ARN](#output\_LAMBDA\_FUNCTION\_ARN) | To control if an S3 bucket should have lambda access bucket policies attached |
| <a name="output_LOCALS_CORS_RULES"></a> [LOCALS\_CORS\_RULES](#output\_LOCALS\_CORS\_RULES) | List of maps containing rules for Cross-Origin Resource Sharing to be assigned on Locals |
| <a name="output_LOCALS_GRANT"></a> [LOCALS\_GRANT](#output\_LOCALS\_GRANT) | ACL policy grant to be assigned on Locals. Conflicts with 'acl' |
| <a name="output_LOCALS_INTELLIGENT_TIERING"></a> [LOCALS\_INTELLIGENT\_TIERING](#output\_LOCALS\_INTELLIGENT\_TIERING) | Map containing intelligent tiering configuration to be assigned on Locals |
| <a name="output_LOCALS_LIFECYCLE_RULES"></a> [LOCALS\_LIFECYCLE\_RULES](#output\_LOCALS\_LIFECYCLE\_RULES) | List of maps containing configuration of object lifecycle management to be assigned on Locals |
| <a name="output_OBJECT_LOCK"></a> [OBJECT\_LOCK](#output\_OBJECT\_LOCK) | To define Whether S3 bucket should have an Object Lock configuration |
| <a name="output_OBJECT_LOCK_CONFIGURATION"></a> [OBJECT\_LOCK\_CONFIGURATION](#output\_OBJECT\_LOCK\_CONFIGURATION) | Map OF S3 object locking configuration |
| <a name="output_OBJECT_OWNERSHIP"></a> [OBJECT\_OWNERSHIP](#output\_OBJECT\_OWNERSHIP) | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL. |
| <a name="output_PAYMENT_CONFIGURATION_REQUEST_PAYER"></a> [PAYMENT\_CONFIGURATION\_REQUEST\_PAYER](#output\_PAYMENT\_CONFIGURATION\_REQUEST\_PAYER) | Specification of who should bear the cost of Amazon S3 data transfer. Accepted values are BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information. |
| <a name="output_POLICY_JSON"></a> [POLICY\_JSON](#output\_POLICY\_JSON) | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. |
| <a name="output_PROJECT_NAME"></a> [PROJECT\_NAME](#output\_PROJECT\_NAME) | The project name that will be prefixed to resource names |
| <a name="output_REPLICATION_CONFIGURATION"></a> [REPLICATION\_CONFIGURATION](#output\_REPLICATION\_CONFIGURATION) | Map of cross-region replication configuration. |
| <a name="output_RESTRICT_PUBLIC_BUCKETS"></a> [RESTRICT\_PUBLIC\_BUCKETS](#output\_RESTRICT\_PUBLIC\_BUCKETS) | To define whether Amazon S3 should restrict public bucket policies for this bucket |
| <a name="output_SERVER_SIDE_ENCRYPTION_CONFIGURATION"></a> [SERVER\_SIDE\_ENCRYPTION\_CONFIGURATION](#output\_SERVER\_SIDE\_ENCRYPTION\_CONFIGURATION) | Server-side encryption configuration |
| <a name="output_TAGS"></a> [TAGS](#output\_TAGS) | Tag List |
| <a name="output_WEBSITE"></a> [WEBSITE](#output\_WEBSITE) | Map containing static web-site hosting or redirect configuration. |
<!-- END_TF_DOCS -->