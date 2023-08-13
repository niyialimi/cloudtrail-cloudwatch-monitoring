locals {
  metrics = [
    { 
      "name": "signin-without-mfa",
      "pattern": "{($.eventType = 'AwsConsoleSignIn') && ($.additionalEventData.MFAUsed = 'No')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "signin-failures",
      "pattern": "{($.eventType = 'AwsConsoleSignIn') && ($.errorMessage = 'Failed authentication')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "root-account-usage",
      "pattern": "{($.userIdentity.type = 'Root') && ($.eventName != 'CreateAccount')}",
      "namespace": "CloudTrailMetrics",
       "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "s3-policy-changes",
      "pattern": "{($.eventName = 'PutBucketPolicy') || ($.eventName = 'DeleteBucketPolicy')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "iam-user-changes",
      "pattern": "{($.eventName = 'CreateUser') || ($.eventName = 'DeleteUser') || ($.eventName = 'UpdateUser') || ($.eventName = 'AttachUserPolicy') || ($.eventName = 'DetachUserPolicy') || ($.eventName = 'PutUserPolicy')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "iam-role-changes",
      "pattern": "{($.eventName = 'CreateRole') || ($.eventName = 'DeleteRole') || ($.eventName = 'UpdateRole') || ($.eventName = 'AttachRolePolicy') || ($.eventName = 'DetachRolePolicy') || ($.eventName = 'PutRolePolicy')}",
      "namespace": "CloudTrailMetrics",
       "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "iam-group-changes",
      "pattern": "{($.eventName = 'CreateGroup') || ($.eventName = 'DeleteGroup') || ($.eventName = 'UpdateGroup') || ($.eventName = 'AttachGroupPolicy') || ($.eventName = 'DetachGroupPolicy') || ($.eventName = 'PutGroupPolicy')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "iam-policy-changes",
      "pattern": "{($.eventName = 'CreatePolicy') || ($.eventName = 'DeletePolicy') || ($.eventName = 'UpdatePolicy' || ($.eventName = 'CreatePolicyVersion') || ($.eventName = 'DeletePolicyVersion')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "network-acl-changes",
      "pattern": "{($.eventName = 'CreateNetworkAcl') || ($.eventName = 'CreateNetworkAclEntry') || ($.eventName = 'DeleteNetworkAcl') || ($.eventName = 'DeleteNetworkAclEntry')}",
      "namespace": "CloudTrailMetrics",
       "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "route-table-changes",
      "pattern": "{($.eventName = 'CreateRouteTable') || ($.eventName = 'CreateRoute') || ($.eventName = 'ReplaceRoute') || ($.eventName = 'DeleteRouteTable') || ($.eventName = 'DeleteRoute') || ($.eventName = 'AssociateRouteTable') || ($.eventName = 'DisassociateRouteTable') || ($.eventName = 'ReplaceRouteTableAssociation')}",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "network-changes",
      "pattern": "{($.eventName = 'CreateVpc') || ($.eventName = 'CreateSubnet') || ($.eventName = 'CreateNetworkInterface') || ($.eventName = 'DeleteNetworkInterface') || ($.eventName = 'ModifyNetworkInterfaceAttribute') }",
      "namespace": "CloudTrailMetrics",
      "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    },
    { 
      "name": "unauthorized-api-calls",
      "pattern": "{(($.errorCode = 'AccessDenied') || ($.errorCode = 'UnauthorizedOperation')) && ($.eventSource != 'sts.amazonaws.com')}",
      "namespace": "CloudTrailMetrics",
       "alarm": {
        "comparison_operator": "GreaterThanOrEqualToThreshold",
        "evaluation_periods": 1, #one data point
        "period": var.period, #5 min
        "statistic": "Sum",
        "threshold": var.threshold,
      }
    }
  ]
}

# Create CloudWatch log group
resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.environment}-${var.project}-trail"
  retention_in_days = 90
}

# Create CloudTrail trail
resource "aws_cloudtrail" "trails" {
  name                          = "${var.environment}-${var.project}-trail"
  s3_bucket_name                = aws_s3_bucket.trail-bucket.id
  s3_key_prefix                 = "trails"
  include_global_service_events = true
  cloud_watch_logs_role_arn = aws_iam_role.cloudtrail-roles.arn
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.log-group.arn}:*"
  depends_on = [aws_s3_bucket_policy.bucket-policy]
}

# CloudWatch Metric Filters
resource "aws_cloudwatch_log_metric_filter" "trail-metrics" {
  for_each = {
    for m in local.metrics: m.name => m
  }
  name = each.value.name
  pattern = each.value.pattern
  log_group_name = aws_cloudwatch_log_group.log-group.name
  metric_transformation {
    name = "${each.value.name}-metric"
    namespace = each.value.namespace
    value = "1"
  }
}

# # CloudWatch Metric Alarms
resource "aws_cloudwatch_metric_alarm" "metric-alarms" {
  for_each = {
    for m in local.metrics: m.name => m
  }
  alarm_name                = "${each.value.name}-alarm"
  alarm_description         = "Metric from cloudtrail. Alarm triggered when suspicious activity is detected"
  metric_name = each.value.name
  namespace = each.value.namespace
  
  comparison_operator = each.value.alarm.comparison_operator
  evaluation_periods = each.value.alarm.evaluation_periods
  period = each.value.alarm.period
  statistic = each.value.alarm.statistic
  threshold = each.value.alarm.threshold
  alarm_actions = [
    aws_sns_topic.trail-log-metrics.arn
  ]
}

# Create SNS and Email Notification
resource "aws_sns_topic" "trail-log-metrics" {
  name = "${var.environment}-${var.project}-trail-log-metrics-topic"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.trail-log-metrics.arn
  protocol  = "email"
  endpoint  = "${var.endpoint}"
}