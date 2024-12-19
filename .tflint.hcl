plugin "aws" {
    enabled = true
    version = "0.36.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
    deep_check = false
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags = [
    "Environment",
    "Region",
    "Version",
  ]
}
