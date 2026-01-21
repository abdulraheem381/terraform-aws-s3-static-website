
# Terraform AWS S3 Static Website

A production-ready Terraform project that automates the deployment of a static website on **Amazon S3**. This infrastructure-as-code solution handles bucket creation, website configuration, and public access policies with minimal manual effort.

## 🎯 Features

- **Automated S3 Bucket Provisioning** — Creates a unique S3 bucket with random suffix to ensure global uniqueness
- **Static Website Hosting** — Configures S3 for website hosting with index.html as the default document
- **Public Access** — Implements proper bucket policies to allow public read access to website files
- **Automated Uploads** — Deploys `index.html`, `styles.css`, and `script.js` automatically
- **Website Endpoint** — Outputs the public URL for instant access to your website
- **Infrastructure Destruction** — Easy cleanup with `terraform destroy` command

## 📁 Project Structure

```
├── main.tf              # Core Terraform configuration (S3 bucket, website hosting, IAM policies)
├── providers.tf         # AWS provider configuration
├── README.md            # This file
├── index.html           # Landing page (customize title and content)
├── styles.css           # Styling with gradient background
├── script.js            # JavaScript for interactive features
└── LICENSE              # Project license
```

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

1. **Terraform** (v1.0 or higher)
   - Download from: https://www.terraform.io/downloads.html
   - Verify installation: `terraform --version`

2. **AWS Account** with appropriate permissions
   - Required IAM permissions: S3, CloudFront (if using CDN)
   - Access Key ID and Secret Access Key configured

3. **AWS CLI** (optional but recommended)
   - Configure credentials: `aws configure`
   - Verify setup: `aws sts get-caller-identity`

## 🚀 Quick Start

### Step 1: Initialize Terraform

```bash
terraform init
```

This downloads the necessary Terraform plugins and initializes the working directory.

### Step 2: Review the Plan

```bash
terraform plan
```

This command shows all resources that will be created. Review the output to ensure everything looks correct.

### Step 3: Deploy

```bash
terraform apply
```

Terraform will prompt for confirmation. Type `yes` to proceed with the deployment.

### Step 4: Access Your Website

After successful deployment, Terraform will output the website endpoint URL:

```
website_endpoint = http://your-bucket-name.s3-website-region.amazonaws.com
```

Copy this URL into your browser to view your website.

## 🎨 Customization

### Update Website Content

- **index.html** — Edit the page title, heading, and content
- **styles.css** — Modify colors, fonts, and layout
- **script.js** — Add JavaScript interactivity

Simply edit these files and run `terraform apply` again to push updates to S3.

### Configure AWS Region

Edit `providers.tf` to change the deployment region:

```hcl
region = "us-east-1"  # Change to your preferred region
```

## 🧹 Clean Up

To remove all AWS resources and avoid ongoing charges:

```bash
terraform destroy
```

Type `yes` when prompted to confirm deletion.

## 📚 How It Works

1. **Random Suffix** — Appends a random suffix to the bucket name to ensure uniqueness across AWS
2. **Website Configuration** — Enables S3 static website hosting with index.html as the entry point
3. **Public Access Policy** — Grants read-only permissions to all objects for public access
4. **File Upload** — Automatically uploads web assets to the S3 bucket
5. **URL Output** — Displays the website endpoint for easy access

## 🛡️ Security Considerations

- The S3 bucket is configured for **public read access only** — no upload/delete permissions
- Block public access settings are disabled to allow website hosting
- Consider adding CloudFront CDN for production use
- Use S3 versioning for backup and rollback capabilities

## 🐛 Troubleshooting

**Error: "bucket already exists"**
- S3 bucket names are globally unique; the random suffix may still conflict
- Modify the bucket name prefix in `main.tf`

**Error: "access denied"**
- Verify AWS credentials are properly configured
- Check IAM permissions for S3 and related services

**Website not loading**
- Allow 1-2 minutes for S3 to propagate the changes
- Verify that `index.html` exists in the S3 bucket
- Check bucket policy allows public read access

## 📝 License

See the [LICENSE](LICENSE) file for details.

## 💬 Support

For issues or questions, please refer to:
- [Terraform Documentation](https://www.terraform.io/docs/)
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)



