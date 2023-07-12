variable "create" {
  description = "Whether to create Glue Database resource"
  type        = bool
  default     = true
}

variable "glue_database_name" {
  description = "Name of the Glue catalog database."
  type        = string
}

variable "job_name" {
}

variable "s3_target_bucket_name" {
  description = "S3 target bucket for Glue crawler."
  type        = string
}

variable "target_path" {
  description = "Path to crawler target file(s)."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming"
  type        = string
}
variable "params" {
  type    = map(any)
  default = {}
}

variable "catalog_id" {
  type    = string
  default = null
}

variable "location_uri" {
  type    = string
  default = null
}

variable "description" {
  type    = string
  default = "A Glue DB"
}

variable "glue_script_path" {
  type = string
}

variable "worker_type" {
  type = string
}

variable "number_of_workers" {
  type = string
}

variable "glue_version" {
  type = string
}

variable "execution_class" {
  type = string
  description = "Indicates whether the job is run with a standard or flexible execution class. Valid value: FLEX, STANDARD"
}

variable "default_arguments" {
}

variable "kms_key" {
}

variable "s3_database_location" {
  type        = string
  description = "Connection for the main database"
}