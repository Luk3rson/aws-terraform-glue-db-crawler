locals {
  crawler_bucket_path = "s3://${var.s3_target_bucket_name}/${var.target_path}"
  glue_script_path    = "s3://${var.s3_target_bucket_name}/${var.glue_script_path}"
  name                = "${var.name_prefix}-crawler"
}