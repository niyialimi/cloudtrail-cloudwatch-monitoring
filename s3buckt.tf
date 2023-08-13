locals {
  root_tags = {
    project     = "${var.project}"
    environment = var.environment
  }
}

resource "random_uuid" "generator" {
}

#Create Bucket for Trail Logs
resource "aws_s3_bucket" "trail-bucket" {
  bucket = "trail-bucket-${random_uuid.generator.id}"
  acl    = "private"

  tags = local.root_tags
}


resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = "${aws_s3_bucket.trail-bucket.id}"

  policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.trail-bucket.id}"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.trail-bucket.id}/trails/AWSLogs/*",
        "Condition": {
          "StringEquals": {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
      }
    ]
  }
  POLICY
}