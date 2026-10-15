# AWS Java RnD

Hands-on AWS projects in Java 21 and Spring Boot 3, plus the Terraform used to provision test resources. Each folder is an independent project with its own README.

| Project | What it demonstrates | CI |
|---|---|---|
| [`spring-boot-aws-sdk-v2`](spring-boot-aws-sdk-v2) | AWS SDK v2 from Spring Boot: S3 (upload, stream, presigned URLs, download, delete), SQS standard + FIFO (SDK v2 sender, Spring Cloud AWS listener), Secrets Manager and SSM Parameter Store | [![build](https://github.com/fahimfahad92/aws-java-rnd/actions/workflows/spring-boot-aws-sdk-v2.yml/badge.svg)](https://github.com/fahimfahad92/aws-java-rnd/actions/workflows/spring-boot-aws-sdk-v2.yml) |
| [`lambda-spring-boot`](lambda-spring-boot) | Spring Boot 3 REST app running on AWS Lambda via aws-serverless-java-container, SAM template, Java Lambda cold-start tuning (SnapStart, tiered compilation, priming) | [![build](https://github.com/fahimfahad92/aws-java-rnd/actions/workflows/lambda-spring-boot.yml/badge.svg)](https://github.com/fahimfahad92/aws-java-rnd/actions/workflows/lambda-spring-boot.yml) |
| [`terraform`](terraform) | Terraform for test resources: S3 bucket, SQS queue with DLQ and queue policies, EventBridge Scheduler → SQS with IAM role | — |

**Stack:** Java 21 · Spring Boot 3 · AWS SDK v2 · Spring Cloud AWS · S3 · SQS · Secrets Manager · SSM · Lambda · SAM · EventBridge · Terraform

## Blog posts

- [How to Integrate Spring Boot 3 with Amazon S3 Using AWS SDK v2](https://awstip.com/how-to-integrate-spring-boot-3-with-amazon-s3-using-aws-sdk-v2-c5500f01df31)
- [How to Integrate Spring Boot 3 with Amazon SQS Using AWS SDK v2](https://awstip.com/how-to-integrate-spring-boot-3-with-amazon-sqs-using-aws-sdk-v2-044e93e4fc11)
- [How to Integrate Spring Boot 3 with AWS Secret Manager and Parameter Store Using AWS SDK v2](https://awstip.com/how-to-integrate-spring-boot-3-with-aws-secret-manager-and-parameter-store-using-aws-sdk-v2-390a59cfdbae)
- [Terraform: manage AWS resources](https://awstip.com/terraform-manage-aws-resources-968dedab5a7b)

## History

This repository was `java-spring-boot-aws-rnd` (now `spring-boot-aws-sdk-v2/`; old links redirect here). Merged in with full commit history: `java-21-spring-boot-3-lambda`, `aws-test-resources`.

## License

[MIT](LICENSE)
