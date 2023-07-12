resource "aws_glue_catalog_database" "glue_database" {
  count        = var.create ? 1 : 0
  name         = var.glue_database_name
  catalog_id   = var.catalog_id
  description  = var.description
  location_uri = var.location_uri
  parameters   = var.params
}

resource "aws_glue_data_catalog_encryption_settings" "kms" {
  count = var.create ? 1 : 0
  data_catalog_encryption_settings {
    connection_password_encryption {
      aws_kms_key_id                       = var.kms_key.arn
      return_connection_password_encrypted = true
    }

    encryption_at_rest {
      catalog_encryption_mode = "SSE-KMS"
      sse_aws_kms_key_id      = var.kms_key.arn
    }
  }
}


resource "aws_glue_security_configuration" "example" {
  count = var.create ? 1 : 0
  name = "kms"

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = "SSE-KMS"
      kms_key_arn                = var.kms_key.arn
    }

    job_bookmarks_encryption {
      kms_key_arn                   = var.kms_key.arn
      job_bookmarks_encryption_mode = "CSE-KMS"
    }

    s3_encryption {
      kms_key_arn        = var.kms_key.arn
      s3_encryption_mode = "SSE-KMS"
    }
  }
}