terraform {
  backend "s3" {
    bucket  = "niyi-alimi-state-file"
    key     = "cloudtrail_cloudwatch.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
    dynamodb_table="niyi-alimi-state-lock"
  }
}