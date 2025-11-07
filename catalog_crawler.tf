# Create Glue Data Catalog Database
resource "aws_glue_catalog_database" "finance_database_pre" {
  name         = "finance_database_pre"
  location_uri = "${aws_s3_bucket.source-data-bucket-pre.id}/"
}

# Create Glue Crawler
resource "aws_glue_crawler" "finance_data_crawler_pre" {
  name          = "finance_data_crawler_pre"
  database_name = aws_glue_catalog_database.finance_database_pre.name
  role          = aws_iam_role.glue_service_role.name
  s3_target {
    path = "${aws_s3_bucket.source-data-bucket-pre.id}/"
  }
  schema_change_policy {
    delete_behavior = "LOG"
  }
  configuration = <<EOF
{
  "Version":1.0,
  "Grouping": {
    "TableGroupingPolicy": "CombineCompatibleSchemas"
  }
}
EOF
}
resource "aws_glue_trigger" "finance_data_trigger_pre" {
  name = "finance_data_trigger_pre"
  type = "ON_DEMAND"
  actions {
    crawler_name = aws_glue_crawler.finance_data_crawler_pre.name
  }
}