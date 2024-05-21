terraform {
  backend "s3" {
    bucket = "<your s3 bucket>"
    key    = "<your s3 key>"
    region = "<your region>"
  }
}
