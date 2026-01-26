variable "minio_server" {
  type    = string
  default = "localhost:9000"
}

variable "minio_user" {
  type    = string
  default = "minioadmin"
}

variable "minio_password" {
  type      = string
  sensitive = true
  default   = "minioadmin"
}