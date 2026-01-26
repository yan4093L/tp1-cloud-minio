# TP1 Cloud: Introduction to Cloud with OpenTofu and MinIO
# Yan LIANG M2 MIAGE IPM

## Description
This project automates the deployment of a MinIO infrastructure and a static website using OpenTofu (Infrastructure as Code).

## Prerequisites
- OpenTofu installed
- MinIO server running locally

## How to run
1. Start MinIO server:
   `minio.exe server ./data --console-address ":9001"`
2. Initialize the project:
   `tofu init`
3. Apply the configuration:
   `tofu apply -auto-approve`

## Steps Performed
- [cite_start]Setup of MinIO provider. [cite: 48]
- [cite_start]Creation of two buckets (`tp1-cloud-bucket` and `webbucket`). [cite: 55, 83]
- [cite_start]Upload of `index.html` and `style.css` with `public-read` ACLs. [cite: 87, 93]
- [cite_start]Implementation of variables and secrets for security. [cite: 101]
- [cite_start]Optimized security by keeping buckets private while keeping only necessary objects public. [cite: 108]
- [cite_start]Validated full lifecycle with `tofu destroy` and `tofu apply`. [cite: 113]

## Verification
- Website accessible at: http://localhost:9000/webbucket/index.html
- MinIO Console visible at: http://localhost:9001


## Lancement du serveur MinIO
1. Créez un dossier de travail :
 mkdir ~/minio-data
2. Lancez le serveur MinIO localement :
minio server ~/minio-data --console-address ":9001"
3. Accédez à la console via http://localhost:9001.
 Par défaut, l’utilisateur est 'minioadmin' et le mot de passe 'minioadmin'.

## Création de la configuration OpenTofu
Créez un répertoire de projet nommé 'tp1-minio'. À l’intérieur, créez
un fichier main.tf :
terraform {
 required_providers {
 minio = {
 source = "terraform-provider-minio/minio"
 version = ">= 3.1.0"
 }
 }
}
provider "minio" {
 minio_server = "http://localhost:9000"
 minio_access_key = "minioadmin"
 minio_secret_key = "minioadmin"
 minio_ssl = false
}
resource "minio_s3_bucket" "tp1_bucket" {
 bucket = "tp1-cloud-bucket"
 acl = "private"
}

## Initialisation et déploiement
1. Initialisez le projet :
 tofu init

 2. Vérifiez le plan d’exécution :
tofu plan
3. Appliquez les changements :
 tofu apply
Une fois le déploiement terminé, le bucket 'tp1-cloud-bucket' doit être visible dans la console
MinIO.

## Transformation en site web
Nous allons maintenant faire évoluer le code afin de transformer le bucket en site web statique.
Créer un index.html et un style.css de votre site web.
Modifier votre main.tf de la facon suivante :
provider "minio" {
 minio_server = "127.0.0.1:9000"
 minio_user = "minioadmin"
 minio_password = "minioadmin"
}
resource "minio_s3_bucket" "web_bucket" {
 bucket = "webbucket"
 acl = "public-read"
}
resource "minio_s3_object" "index_html" {
 bucket = minio_s3_bucket.web_bucket.bucket
 object = "index.html"
 source = "index.html"
 acl = "public-read"
}
resource "minio_s3_object" "style_css" {
 bucket = minio_s3_bucket.web_bucket.bucket
 object = "style.css"
 source = "style.css"
 acl = "public-read"
}