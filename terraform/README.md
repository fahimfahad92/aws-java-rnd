This is a personal learning repo. I used Terraform to create basic AWS resources.

**Prerequisite:**

1. Install Terraform
2. Install AWS CLI
3. Configure an AWS IAM user to execute resource creation commands.

In this repo, I added some Terraform files to demonstrate how to perform the below resources:

1. S3 bucket
2. SQS and DLQ for the SQS
3. EventBridge scheduler that pushes the message to the SQS created in step 2.

**Medium Link:** https://awstip.com/terraform-manage-aws-resources-968dedab5a7b
