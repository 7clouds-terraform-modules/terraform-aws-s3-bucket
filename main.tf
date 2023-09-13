###########################################################################################
#                                       DATA                                              #
###########################################################################################
data "aws_caller_identity" "current" {}

###########################################################################################
#                                      LOCALS                                             #
###########################################################################################
locals {
  grants              = try(jsondecode(var.LOCALS_GRANT), var.LOCALS_GRANT)
  cors_rules          = try(jsondecode(var.LOCALS_CORS_RULES), var.LOCALS_CORS_RULES)
  lifecycle_rules     = try(jsondecode(var.LOCALS_LIFECYCLE_RULES), var.LOCALS_LIFECYCLE_RULES)
  intelligent_tiering = try(jsondecode(var.LOCALS_INTELLIGENT_TIERING), var.LOCALS_INTELLIGENT_TIERING)
}

###########################################################################################
#                                       DATA                                              #
# ###########################################################################################
data "aws_iam_policy_document" "allow_lambda_access" {
  count = var.CREATE_BUCKET && var.LAMBDA_FUNCTION_ARN != null ? 1 : 0
  statement {
    sid    = "allowLambdaAccess"
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      join("", aws_s3_bucket.this.*.arn),
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [var.LAMBDA_FUNCTION_ARN]
    }
  }
}

data "aws_iam_policy_document" "allow_ecs_access" {
  count = var.CREATE_BUCKET && var.ECS_SERVICE_ARN != null ? 1 : 0
  statement {
    sid    = "allowECSAccess"
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      join("", aws_s3_bucket.this.*.arn),
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [var.ECS_SERVICE_ARN]
    }
  }
}

data "aws_iam_policy_document" "allow_eks_access" {
  count = var.CREATE_BUCKET && var.EKS_WORKLOAD_ARN != null ? 1 : 0
  statement {
    sid    = "allowEKSAccess"
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      join("", aws_s3_bucket.this.*.arn),
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [var.EKS_WORKLOAD_ARN]
    }
  }
}

data "aws_iam_policy_document" "require_latest_tls" {
  count = var.CREATE_BUCKET && var.ATTACH_REQUIRE_LATEST_TLS_POLICY ? 1 : 0
  statement {
    sid    = "denyOutdatedTLS"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      join("", aws_s3_bucket.this.*.arn),
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "NumericLessThan"
      variable = "s3:TlsVersion"
      values = [
        "1.2"
      ]
    }
  }
}

data "aws_elb_service_account" "this" {
  count = var.CREATE_BUCKET && var.ATTACH_ELB_LOG_DELIVERY_POLICY ? 1 : 0
}

data "aws_iam_policy_document" "elb_log_delivery" { #ELB
  count = var.CREATE_BUCKET && var.ATTACH_ELB_LOG_DELIVERY_POLICY ? 1 : 0
  statement {
    sid = ""
    principals {
      type        = "AWS"
      identifiers = data.aws_elb_service_account.this.*.arn
    }
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
  }
}

data "aws_iam_policy_document" "lb_log_delivery" { # ALB/NLB
  count = var.CREATE_BUCKET && var.ATTACH_LB_LOG_DELIVERY_POLICY ? 1 : 0
  statement {
    sid = "AWSLogDeliveryWrite"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
  statement {
    sid    = "AWSLogDeliveryAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl",
    ]
    resources = [
      join("", aws_s3_bucket.this.*.arn),
    ]
  }
}

data "aws_iam_policy_document" "deny_insecure_transport" {
  count = var.CREATE_BUCKET && var.ATTACH_DENY_INSECURE_TRANSPORT_POLICY ? 1 : 0
  statement {
    sid    = "denyInsecureTransport"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      join("", aws_s3_bucket.this.*.arn),
      "${join("", aws_s3_bucket.this.*.arn)}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

data "aws_iam_policy_document" "combined" {
  count = var.CREATE_BUCKET && var.ATTACH_POLICY ? 1 : 0
  source_policy_documents = compact([
    var.LAMBDA_FUNCTION_ARN != null ? join("", data.aws_iam_policy_document.allow_lambda_access.*.json) : "",
    var.ECS_SERVICE_ARN != null ? join("", data.aws_iam_policy_document.allow_ecs_access.*.json) : "",
    var.EKS_WORKLOAD_ARN != null ? join("", data.aws_iam_policy_document.allow_eks_access.*.json) : "",
    var.ATTACH_REQUIRE_LATEST_TLS_POLICY ? join("", data.aws_iam_policy_document.require_latest_tls.*.json) : "",
    var.ATTACH_ELB_LOG_DELIVERY_POLICY ? join("", data.aws_iam_policy_document.elb_log_delivery.*.json) : "",
    var.ATTACH_LB_LOG_DELIVERY_POLICY ? join("", data.aws_iam_policy_document.lb_log_delivery.*.json) : "",
    var.ATTACH_DENY_INSECURE_TRANSPORT_POLICY ? join("", data.aws_iam_policy_document.deny_insecure_transport.*.json) : "",
    var.ATTACH_POLICY ? var.POLICY_JSON : ""
  ])
}

###########################################################################################
#                                        S3                                               #
###########################################################################################
resource "aws_s3_bucket" "this" {
  count  = var.CREATE_BUCKET ? 1 : 0
  bucket = var.CONTENT_BUCKET
  tags = var.TAGS != null ? "${
    merge(var.TAGS, {
      Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} S3 Bucket" : "S3 Bucket" }
    )}" : {
    Name = var.PROJECT_NAME != "" ? "${var.PROJECT_NAME} S3 Bucket" : "S3 Bucket"
  }
  force_destroy       = var.CONTENT_BUCKET_FORCE_DESTROY
  bucket_prefix       = var.CONTENT_BUCKET_PREFIX != null ? var.CONTENT_BUCKET_PREFIX : null
  object_lock_enabled = var.CONTENT_BUCKET_OBJECT_LOCKED_ENABLED != null ? var.CONTENT_BUCKET_OBJECT_LOCKED_ENABLED : null
}

resource "aws_s3_bucket_policy" "this" {
  count = var.CREATE_BUCKET && (
    var.LAMBDA_FUNCTION_ARN != null ||
    var.ECS_SERVICE_ARN != null ||
    var.EKS_WORKLOAD_ARN != null ||
    var.ATTACH_REQUIRE_LATEST_TLS_POLICY ||
    var.ATTACH_ELB_LOG_DELIVERY_POLICY ||
    var.ATTACH_LB_LOG_DELIVERY_POLICY ||
    var.ATTACH_DENY_INSECURE_TRANSPORT_POLICY ||
  var.ATTACH_POLICY) ? 1 : 0
  bucket = join("", aws_s3_bucket.this.*.id)
  policy = join("", data.aws_iam_policy_document.combined.*.json)
}

# Chain resources (s3_bucket -> s3_bucket_policy -> s3_bucket_public_access_block)
# to prevent "A conflicting conditional operation is currently in progress against this resource."
# Ref: https://github.com/hashicorp/terraform-provider-aws/issues/7628
resource "aws_s3_bucket_public_access_block" "this" {
  count                   = var.CREATE_BUCKET && var.ATTACH_PUBLIC_POLICY ? 1 : 0
  bucket                  = var.ATTACH_POLICY ? join("", aws_s3_bucket_policy.this.*.id) : join("", aws_s3_bucket.this.*.id)
  block_public_acls       = var.BLOCK_PUBLIC_ACLS
  block_public_policy     = var.BLOCK_PUBLIC_POLICY
  ignore_public_acls      = var.IGNORE_PUBLIC_ACLS
  restrict_public_buckets = var.RESTRICT_PUBLIC_BUCKETS
}

resource "aws_s3_bucket_versioning" "this" {
  count                 = var.CREATE_BUCKET && length(keys(var.BUCKET_VERSIONING)) > 0 ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  mfa                   = try(var.BUCKET_VERSIONING["mfa"], null)
  versioning_configuration {
    status     = try(var.BUCKET_VERSIONING["enabled"] ? "Enabled" : "Suspended", tobool(var.BUCKET_VERSIONING["status"]) ? "Enabled" : "Suspended", title(lower(var.BUCKET_VERSIONING["status"])))
    mfa_delete = try(tobool(var.BUCKET_VERSIONING["mfa_delete"]) ? "Enabled" : "Disabled", title(lower(var.BUCKET_VERSIONING["mfa_delete"])), null)
  }
}

resource "aws_s3_bucket_logging" "this" {
  count                 = var.CREATE_BUCKET && var.BUCKET_LOGGING_ENABLED ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  target_bucket         = var.BUCKET_LOGGING_TARGET_BUCKET
  target_prefix         = var.BUCKET_LOGGING_TARGET_PREFIX
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
}

resource "aws_s3_bucket_acl" "this" {
  count                 = var.CREATE_BUCKET && ((var.BUCKET_ACL != null && var.BUCKET_ACL != "null") || length(local.grants) > 0) ? 1 : 0
  acl                   = var.BUCKET_ACL == "null" ? null : var.BUCKET_ACL
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  dynamic "access_control_policy" {
    for_each = length(local.grants) > 0 ? [true] : []
    content {
      dynamic "grant" {
        for_each = local.grants
        content {
          permission = grant.value.permission
          grantee {
            type          = grant.value.type
            id            = try(grant.value.id, null)
            uri           = try(grant.value.uri, null)
            email_address = try(grant.value.email, null)
          }
        }
      }
      owner {
        id           = try(var.owner["id"], data.aws_canonical_user_id.this.id)
        display_name = try(var.owner["display_name"], null)
      }
    }
  }
  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_website_configuration" "this" {
  count                 = var.CREATE_BUCKET && length(keys(var.WEBSITE)) > 0 ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  dynamic "redirect_all_requests_to" {
    for_each = try([var.WEBSITE["redirect_all_requests_to"]], [])
    content {
      host_name = redirect_all_requests_to.value.host_name
      protocol  = try(redirect_all_requests_to.value.protocol, null)
    }
  }
  dynamic "routing_rule" {
    for_each = try(flatten([var.WEBSITE["routing_rules"]]), [])
    content {
      dynamic "condition" {
        for_each = [try([routing_rule.value.condition], [])]
        content {
          http_error_code_returned_equals = try(routing_rule.value.condition["http_error_code_returned_equals"], null)
          key_prefix_equals               = try(routing_rule.value.condition["key_prefix_equals"], null)
        }
      }
      redirect {
        host_name               = try(routing_rule.value.redirect["host_name"], null)
        http_redirect_code      = try(routing_rule.value.redirect["http_redirect_code"], null)
        protocol                = try(routing_rule.value.redirect["protocol"], null)
        replace_key_prefix_with = try(routing_rule.value.redirect["replace_key_prefix_with"], null)
        replace_key_with        = try(routing_rule.value.redirect["replace_key_with"], null)
      }
    }
  }
  dynamic "index_document" {
    for_each = try([var.WEBSITE["index_document"]], [])
    content {
      suffix = index_document.value
    }
  }
  dynamic "error_document" {
    for_each = try([var.WEBSITE["error_document"]], [])
    content {
      key = error_document.value
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count                 = var.CREATE_BUCKET && length(keys(var.SERVER_SIDE_ENCRYPTION_CONFIGURATION)) > 0 ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  dynamic "rule" {
    for_each = try(flatten([var.SERVER_SIDE_ENCRYPTION_CONFIGURATION["rule"]]), [])
    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)
      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])
        content {
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    }
  }
}

resource "aws_s3_bucket_accelerate_configuration" "this" {
  count                 = var.CREATE_BUCKET && var.ACCELERATION_CONFIGURATION_STATUS != null ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  status                = title(lower(var.ACCELERATION_CONFIGURATION_STATUS))
}

resource "aws_s3_bucket_request_payment_configuration" "this" {
  count                 = var.CREATE_BUCKET && var.PAYMENT_CONFIGURATION_REQUEST_PAYER != null ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  payer                 = lower(var.PAYMENT_CONFIGURATION_REQUEST_PAYER) == "requester" ? "Requester" : "BucketOwner"
}

resource "aws_s3_bucket_cors_configuration" "this" {
  count                 = var.CREATE_BUCKET && length(local.cors_rules) > 0 ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  dynamic "cors_rule" {
    for_each = local.cors_rules
    content {
      id              = try(cors_rule.value.id, null)
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count                 = var.CREATE_BUCKET && length(local.lifecycle_rules) > 0 ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  dynamic "rule" {
    for_each = local.lifecycle_rules
    content {
      id     = try(rule.value.id, null)
      status = try(rule.value.enabled ? "Enabled" : "Disabled", tobool(rule.value.status) ? "Enabled" : "Disabled", title(lower(rule.value.status)))
      dynamic "abort_incomplete_multipart_upload" { # 1 Block Max - abort_incomplete_multipart_upload
        for_each = try([rule.value.abort_incomplete_multipart_upload_days], [])
        content {
          days_after_initiation = try(rule.value.abort_incomplete_multipart_upload_days, null)
        }
      }
      dynamic "expiration" { # 1 Block Max - expiration
        for_each = try(flatten([rule.value.expiration]), [])
        content {
          date                         = try(expiration.value.date, null)
          days                         = try(expiration.value.days, null)
          expired_object_delete_marker = try(expiration.value.expired_object_delete_marker, null)
        }
      }
      dynamic "transition" { # Several Blocks Max - transition
        for_each = try(flatten([rule.value.transition]), [])
        content {
          date          = try(transition.value.date, null)
          days          = try(transition.value.days, null)
          storage_class = transition.value.storage_class
        }
      }
      dynamic "noncurrent_version_expiration" { # 1 Block Max - noncurrent_version_expiration
        for_each = try(flatten([rule.value.noncurrent_version_expiration]), [])
        content {
          newer_noncurrent_versions = try(noncurrent_version_expiration.value.newer_noncurrent_versions, null)
          noncurrent_days           = try(noncurrent_version_expiration.value.days, noncurrent_version_expiration.value.noncurrent_days, null)
        }
      }
      dynamic "noncurrent_version_transition" { # Several Blocks Max - noncurrent_version_transition
        for_each = try(flatten([rule.value.noncurrent_version_transition]), [])
        content {
          newer_noncurrent_versions = try(noncurrent_version_transition.value.newer_noncurrent_versions, null)
          noncurrent_days           = try(noncurrent_version_transition.value.days, noncurrent_version_transition.value.noncurrent_days, null)
          storage_class             = noncurrent_version_transition.value.storage_class
        }
      }
      dynamic "filter" { # 1 Block Max - No key arguments or tags
        for_each = length(try(flatten([rule.value.filter]), [])) == 0 ? [true] : []
        content {
        }
      }
      dynamic "filter" { # 1 Block Max - One key argument or a single tag
        for_each = [for v in try(flatten([rule.value.filter]), []) : v if max(length(keys(v)), length(try(rule.value.filter.tags, rule.value.filter.tag, []))) == 1]
        content {
          object_size_greater_than = try(filter.value.object_size_greater_than, null)
          object_size_less_than    = try(filter.value.object_size_less_than, null)
          prefix                   = try(filter.value.prefix, null)
          dynamic "tag" {
            for_each = try(filter.value.tags, filter.value.tag, [])
            content {
              key   = tag.key
              value = tag.value
            }
          }
        }
      }
      dynamic "filter" { # 1 Block Max - More than one key arguments or multiple tags
        for_each = [for v in try(flatten([rule.value.filter]), []) : v if max(length(keys(v)), length(try(rule.value.filter.tags, rule.value.filter.tag, []))) > 1]
        content {
          and {
            object_size_greater_than = try(filter.value.object_size_greater_than, null)
            object_size_less_than    = try(filter.value.object_size_less_than, null)
            prefix                   = try(filter.value.prefix, null)
            tags                     = try(filter.value.tags, filter.value.tag, null)
          }
        }
      }
    }
  }
  depends_on = [aws_s3_bucket_versioning.this]
}

resource "aws_s3_bucket_replication_configuration" "this" {
  count  = var.CREATE_BUCKET && length(keys(var.REPLICATION_CONFIGURATION)) > 0 ? 1 : 0
  bucket = join("", aws_s3_bucket.this.*.id)
  role   = var.REPLICATION_CONFIGURATION["role"]
  dynamic "rule" {
    for_each = flatten(try([var.REPLICATION_CONFIGURATION["rule"]], [var.REPLICATION_CONFIGURATION["rules"]], []))
    content {
      id       = try(rule.value.id, null)
      priority = try(rule.value.priority, null)
      prefix   = try(rule.value.prefix, null)
      status   = try(tobool(rule.value.status) ? "Enabled" : "Disabled", title(lower(rule.value.status)), "Enabled")
      dynamic "delete_marker_replication" {
        for_each = flatten(try([rule.value.delete_marker_replication_status], [rule.value.delete_marker_replication], []))
        content {
          status = try(tobool(delete_marker_replication.value) ? "Enabled" : "Disabled", title(lower(delete_marker_replication.value)))
        }
      }
      # Amazon S3 does not support this argument according to:
      # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration
      # https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication-what-is-isnot-replicated.html
      dynamic "existing_object_replication" {
        for_each = flatten(try([rule.value.existing_object_replication_status], [rule.value.existing_object_replication], []))
        content {
          status = try(tobool(existing_object_replication.value) ? "Enabled" : "Disabled", title(lower(existing_object_replication.value)))
        }
      }
      dynamic "destination" {
        for_each = try(flatten([rule.value.destination]), [])
        content {
          bucket        = destination.value.bucket
          storage_class = try(destination.value.storage_class, null)
          account       = try(destination.value.account_id, destination.value.account, null)
          dynamic "access_control_translation" {
            for_each = try(flatten([destination.value.access_control_translation]), [])
            content {
              owner = title(lower(access_control_translation.value.owner))
            }
          }
          dynamic "encryption_configuration" {
            for_each = flatten([try(destination.value.encryption_configuration.replica_kms_key_id, destination.value.replica_kms_key_id, [])])
            content {
              replica_kms_key_id = encryption_configuration.value
            }
          }
          dynamic "replication_time" {
            for_each = try(flatten([destination.value.replication_time]), [])
            content {
              status = try(tobool(replication_time.value.status) ? "Enabled" : "Disabled", title(lower(replication_time.value.status)), "Disabled")
              dynamic "time" {
                for_each = try(flatten([replication_time.value.minutes]), [])
                content {
                  minutes = replication_time.value.minutes
                }
              }
            }
          }
          dynamic "metrics" {
            for_each = try(flatten([destination.value.metrics]), [])
            content {
              status = try(tobool(metrics.value.status) ? "Enabled" : "Disabled", title(lower(metrics.value.status)), "Disabled")
              dynamic "event_threshold" {
                for_each = try(flatten([metrics.value.minutes]), [])
                content {
                  minutes = metrics.value.minutes
                }
              }
            }
          }
        }
      }
      dynamic "source_selection_criteria" {
        for_each = try(flatten([rule.value.source_selection_criteria]), [])
        content {
          dynamic "replica_modifications" {
            for_each = flatten([try(source_selection_criteria.value.replica_modifications.enabled, source_selection_criteria.value.replica_modifications.status, [])])
            content {
              status = try(tobool(replica_modifications.value) ? "Enabled" : "Disabled", title(lower(replica_modifications.value)), "Disabled")
            }
          }
          dynamic "sse_kms_encrypted_objects" {
            for_each = flatten([try(source_selection_criteria.value.sse_kms_encrypted_objects.enabled, source_selection_criteria.value.sse_kms_encrypted_objects.status, [])])
            content {
              status = try(tobool(sse_kms_encrypted_objects.value) ? "Enabled" : "Disabled", title(lower(sse_kms_encrypted_objects.value)), "Disabled")
            }
          }
        }
      }
      dynamic "filter" { # 1 Block Max - No key arguments or tags
        for_each = length(try(flatten([rule.value.filter]), [])) == 0 ? [true] : []
        content {
        }
      }
      dynamic "filter" { # 1 Block Max - One key argument or a single tag
        for_each = [for v in try(flatten([rule.value.filter]), []) : v if max(length(keys(v)), length(try(rule.value.filter.tags, rule.value.filter.tag, []))) == 1]
        content {
          prefix = try(filter.value.prefix, null)
          dynamic "tag" {
            for_each = try(filter.value.tags, filter.value.tag, [])
            content {
              key   = tag.key
              value = tag.value
            }
          }
        }
      }
      dynamic "filter" { # 1 Block Max - More than one key argument or multiple tags
        for_each = [for v in try(flatten([rule.value.filter]), []) : v if max(length(keys(v)), length(try(rule.value.filter.tags, rule.value.filter.tag, []))) > 1]
        content {
          and {
            prefix = try(filter.value.prefix, null)
            tags   = try(filter.value.tags, filter.value.tag, null)
          }
        }
      }
    }
  }
  depends_on = [aws_s3_bucket_versioning.this]
}

resource "aws_s3_bucket_object_lock_configuration" "this" {
  count                 = var.CREATE_BUCKET && var.OBJECT_LOCK && try(var.OBJECT_LOCK_CONFIGURATION.rule.default_retention, null) != null ? 1 : 0
  bucket                = join("", aws_s3_bucket.this.*.id)
  expected_bucket_owner = var.EXPECTED_BUCKET_OWNER
  token                 = try(var.OBJECT_LOCK_CONFIGURATION.token, null)
  rule {
    default_retention {
      mode  = var.OBJECT_LOCK_CONFIGURATION.rule.default_retention.mode
      days  = try(var.OBJECT_LOCK_CONFIGURATION.rule.default_retention.days, null)
      years = try(var.OBJECT_LOCK_CONFIGURATION.rule.default_retention.years, null)
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.CREATE_BUCKET && var.CONTROL_OBJECT_OWNERSHIP ? 1 : 0
  bucket = var.ATTACH_POLICY ? join("", aws_s3_bucket_policy.this.*.id) : join("", aws_s3_bucket.this.*.id)
  rule {
    object_ownership = var.OBJECT_OWNERSHIP
  }
  depends_on = [
    aws_s3_bucket_policy.this,
    aws_s3_bucket_public_access_block.this,
    aws_s3_bucket.this
  ]
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  for_each = { for k, v in var.INTELLIGENT_TIERING : k => v if var.CREATE_BUCKET }
  name     = each.key
  bucket   = join("", aws_s3_bucket.this.*.id)
  status   = try(tobool(each.value.status) ? "Enabled" : "Disabled", title(lower(each.value.status)), null)
  dynamic "filter" { # 1 Block Max - Filter
    for_each = length(try(flatten([each.value.filter]), [])) == 0 ? [] : [true]
    content {
      prefix = try(each.value.filter.prefix, null)
      tags   = try(each.value.filter.tags, null)
    }
  }
  dynamic "tiering" {
    for_each = each.value.tiering
    content {
      access_tier = tiering.key
      days        = tiering.value.days
    }
  }
}