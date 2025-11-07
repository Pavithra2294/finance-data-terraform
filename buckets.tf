# S3 Bucket for Source Data
resource "aws_s3_bucket" "source-data-bucket-pre" {
  bucket        = "source-data-bucket-pre"
  force_destroy = true
}

# S3 Bucket for Traget 
resource "aws_s3_bucket" "finance-data-target-pre" {
  bucket        = "finance-data-target-pre"
  force_destroy = true
}

resource "aws_s3_bucket" "glue-code-bucket-pre" {
  bucket = "glue-code-bucket-pre"   # real AWS bucket name (hyphens OK here)
  acl    = "private"
}


resource "aws_s3_object" "glue-code-bucket-pre" {
  bucket = aws_s3_bucket.glue-code-bucket-pre.id
  key    = "finance_data.py"           
  source = "C:/Users/ashok/OneDrive/Desktop/finance-data-terraform/finance_data.py" 
}






