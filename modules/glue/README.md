# AWS Glue with Database and Crawler

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Glue Database | `bool` | `true` | no |
| glue_database\_name | The Database name used to be created from the crawler run. | `string` | `null` | yes |
| name_prefix | The input name of the prefix. | `string` | `null` | yes |
| job_name | The name of the job in AWS Glue. | `string` | `null` | yes |
| s3_target_bucket_name| Destination of the job. | `string` | `null` | yes |
| s3_database_location| The newly created database location. | `string` | `null` | yes |
| target_path| Path of where the action table will be stored. | `string` | `null` | yes |
| glue_script_path | Path of the script locally to be used with the AWS Glue Job | `string` | `null` | yes |
| kms_key | ARN key of the AWS KMS | `string` | `null` | yes |
| worker_type| Worker type. | `string` | `null` | yes |
| number_of_workers| Ammount of workers. | `string` | `null` | yes |
| glue_version | Version of AWS Glue | `string` | `null` | yes |
| execution_class | Execution type. E.g. FLEX  | `string` | `null` | yes |
| default_arguments | Default arguments to be passed to the job. | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|