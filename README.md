
# Terraform AWS — S3 Static Website

A Terraform project that provisions a public static website on **Amazon S3**:
- Unique bucket name (random suffix)
- Uploads `index.html` and `styles.css`
- Enables website hosting + public read (policy)
- Prints the website endpoint on apply

## Files
- `main.tf` — Terraform configuration
- `index.html` — Landing page (edit `<title>` as you like)
- `styles.css` — Simple gradient styling

## Prerequisites
- AWS credentials configured (e.g., `aws configure`)
- Terraform installed

## How to Run
```bash
terraform init
terraform plan
terraform apply
````

Copy the `website_endpoint` from the output into your browser.

## Clean Up

```bash
terraform destroy
```

