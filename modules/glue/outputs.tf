output "glue_crawler_name" {
  value = element(concat(aws_glue_crawler.glue_crawler.*.name, [""]), 0)
}

output "glue_crawler_arn" {
  value = element(concat(aws_glue_crawler.glue_crawler.*.arn, [""]), 0)
}

output "glue_crawler_role_arn" {
  value = aws_iam_role.glue_crawler.arn
}

output "job_name" {
  value = aws_glue_job.main.name
}

output "job_arn" {
  value = aws_glue_job.main.arn
}