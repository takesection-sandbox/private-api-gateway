variable "bucketname" {}
variable "hostedzonename" {}
variable "certificate" {}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket_object" "sample" {
  bucket = "${var.bucketname}"
  key = "sample.yaml"
  source = "sample.yaml"
  etag = "${filemd5("sample.yaml")}"
}

resource "aws_cloudformation_stack" "sample" {
  name = "sample-private-api-gateway"
  template_url = "https://s3.amazonaws.com/${var.bucketname}/sample.yaml"
  capabilities = ["CAPABILITY_NAMED_IAM"]
  parameters = {
    HostedZoneName = "${var.hostedzonename}"
    Certificate = "${var.certificate}"
  }
  tags = [
    { TEMPLATE_VER = "${filemd5("sample.yaml")}" }
  ]
  depends_on = [
    "aws_s3_bucket_object.sample"
  ]
}

