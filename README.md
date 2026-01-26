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
