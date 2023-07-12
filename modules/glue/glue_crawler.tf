resource "aws_glue_crawler" "glue_crawler" {
  count                  = var.create ? 1 : 0
  database_name          = aws_glue_catalog_database.glue_database[0].name
  name                   = local.name
  role                   = aws_iam_role.glue_crawler.arn
  security_configuration = aws_glue_security_configuration.example[0].id
  classifiers            = [aws_glue_classifier.glue_classifier.name]

  s3_target {
    path = local.crawler_bucket_path
  }
}

resource "aws_glue_classifier" "glue_classifier" {
  name = local.name
  csv_classifier {
    contains_header = "PRESENT"
    delimiter       = ","
    quote_symbol    = "'"
  }
}

## IAM Policy
resource "aws_iam_policy" "glue_crawler" {
  name        = local.name
  description = "Policy for Glue crawler and job role"
  path        = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
            "Sid": "AllowAll",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PurchaseReservedCapacityOfferings",
                "logs:AssociateKmsKey",
                "kms:Decrypt"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowRestricted",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:RestoreTableToPointInTime",
                "dynamodb:CreateTableReplica",
                "dynamodb:CreateBackup",
                "dynamodb:UpdateContributorInsights",
                "dynamodb:UpdateGlobalTable",
                "dynamodb:DeleteTable",
                "dynamodb:UpdateTableReplicaAutoScaling",
                "dynamodb:UpdateContinuousBackups",
                "dynamodb:DescribeTable",
                "dynamodb:PartiQLInsert",
                "dynamodb:CreateGlobalTable",
                "dynamodb:EnableKinesisStreamingDestination",
                "dynamodb:DisableKinesisStreamingDestination",
                "dynamodb:BatchWriteItem",
                "dynamodb:UpdateTimeToLive",
                "dynamodb:PutItem",
                "dynamodb:PartiQLUpdate",
                "dynamodb:DeleteTableReplica",
                "dynamodb:UpdateItem",
                "dynamodb:CreateTable",
                "dynamodb:UpdateGlobalTableSettings",
                "s3:PutObject",
                "s3:GetObject",
                "dynamodb:RestoreTableFromBackup",
                "dynamodb:ExportTableToPointInTime",
                "dynamodb:DeleteBackup",
                "dynamodb:UpdateTable",
                "dynamodb:PartiQLDelete"
            ],
            "Resource": [
                "arn:aws:dynamodb:*:250182966077:table/*",
                "arn:aws:s3:::${var.s3_target_bucket_name}/*",
                "arn:aws:s3:::${var.s3_database_location}/*"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "glue_crawler" {
  role       = aws_iam_role.glue_crawler.name
  policy_arn = aws_iam_policy.glue_crawler.arn
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue_crawler.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role" "glue_crawler" {
  name = local.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "glue.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}