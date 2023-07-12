resource "aws_glue_job" "main" {
  name                   = var.job_name
  role_arn               = aws_iam_role.glue_crawler.arn
  number_of_workers      = var.number_of_workers
  worker_type            = var.worker_type
  glue_version           = var.glue_version
  #execution_class        = var.execution_class
  command {
    script_location = local.glue_script_path
  }
  default_arguments = var.default_arguments
}