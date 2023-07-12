# aws-terraform-glue-db-crawler
This repository is mainly used for quick demonstration of AWS Glue service, setting up Crawler and Creating AWS Glue catalog.

In this example you will find initialization of the glue module.
The best practise is to use local variables to ensure, if executed, all environments have a different naming convention:
```hcl
module "glue" {
  source                = "modules/analytics/glue"
  create                = terraform.workspace == "dev" ? true : false
  glue_database_name    = "call-statistics"
  name_prefix           = "main-application-name"
  job_name              = "first-job"
  s3_target_bucket_name = "et-test-bucket"
  s3_database_location  = "${local.s3_database_location}/${local.glue_database_name}/${local.glue_table}"
  target_path           = "data/csv-table"
  glue_script_path      = "etl_scripts/etl-csv-to-dynamoDB.py"
  kms_key               = "1234abcd-12ab-34cd-56ef-1234567890ab"

  # Job
  worker_type           = "G.1X"
  number_of_workers     = "2"
  glue_version          = "3.0"
  execution_class       = "FLEX"
  default_arguments = {
    "--TempDir"             = "s3://etl-test-bucket/temp_dir/"
    "--class"               = "GlueApp"
    "--encryption-type"     = "sse-s3"
    "--job-language"        = "python"
    "--job-bookmark-option" = "job-bookmark-enable"
  }
}
```