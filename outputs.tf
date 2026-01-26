output "website_url" {
  value = "http://${var.minio_server}/${minio_s3_bucket.web_bucket.bucket}/index.html"
}