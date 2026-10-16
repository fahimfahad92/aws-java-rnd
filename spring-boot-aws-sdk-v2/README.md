# Java Spring Boot AWS RnD

A small Spring Boot 3 project for experimenting with AWS services using AWS SDK v2. It currently provides:

- Amazon S3 file operations via REST endpoints (upload file, upload stream, generate presigned URL, download, delete).
- Amazon SQS integration using AWS SDK v2 for sending and Spring Cloud AWS SQS for listening to messages from a Standard queue and a FIFO queue.
- AWS Secrets Manager and SSM Parameter Store reads using AWS SDK v2.

Blog posts:
- [How to Integrate Spring Boot 3 with Amazon S3 Using AWS SDK v2](https://awstip.com/how-to-integrate-spring-boot-3-with-amazon-s3-using-aws-sdk-v2-c5500f01df31)
- [How to Integrate Spring Boot 3 with Amazon SQS Using AWS SDK v2](https://awstip.com/how-to-integrate-spring-boot-3-with-amazon-sqs-using-aws-sdk-v2-044e93e4fc11)
- [How to Integrate Spring Boot 3 with AWS Secret Manager and Parameter Store Using AWS SDK v2](https://awstip.com/how-to-integrate-spring-boot-3-with-aws-secret-manager-and-parameter-store-using-aws-sdk-v2-390a59cfdbae)

## Tech stack
- Java 21
- Spring Boot 3.5.6
- AWS SDK v2 (S3, SQS, Secrets Manager, SSM)
- Spring Cloud AWS SQS (listener)
- Maven

## Prerequisites
- JDK 21+
- Maven 3.9+
- An AWS account with access to S3 and SQS in your chosen region (default: ap-southeast-1).
- Local AWS credentials configured via the default provider chain, e.g. one of:
  - %UserProfile%\.aws\credentials and %UserProfile%\.aws\config
  - Environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION)

## Configuration
Application properties are defined in src\main\resources\application.properties. Key properties:

- server.servlet.context-path=/aws-rnd
- aws.region=<region> (default ap-southeast-1; the AWS_REGION env var overrides it)
- externalServiceSecrets=<secrets-manager-secret-id>
- s3BucketName=<your-bucket-name>
- aws.sqs.queue-url=<standard-queue-url>
- standardQueueName=<standard-queue-name>
- aws.sqs.fifo-queue-url=<fifo-queue-url>
- fifoQueueName=<fifo-queue-name>

Example (from repo):
- s3BucketName=fahim-rnd-project-bucket
- aws.sqs.queue-url=https://sqs.ap-southeast-1.amazonaws.com/<account_id>/Demo-Standard-Queue
- standardQueueName=Demo-Standard-Queue
- aws.sqs.fifo-queue-url=https://sqs.ap-southeast-1.amazonaws.com/<account_id>/Demo-Fifo-Queue.fifo
- fifoQueueName=Demo-Fifo-Queue.fifo

All AWS clients (S3Config, SqsConfig, ExternalServiceSecretManager) read the region from aws.region.

## Build and run
- Build: mvn clean package
- Run (from project root):
  - mvn spring-boot:run
  - or java -jar target\java-spring-boot-aws-rnd-1.0.0.jar

The app runs by default at http://localhost:8080/aws-rnd

## REST API (S3)
Base path: /aws-rnd/api/files

1) Upload file (multipart, temp file on disk)
- POST /api/files
- Form field: file (multipart/form-data)
Example curl (PowerShell):
  curl -Method Post -Uri "http://localhost:8080/aws-rnd/api/files" -Form @{ file = Get-Item .\path\to\yourfile.txt }

2) Upload file (stream)
- POST /api/files/stream
- Form field: file (multipart/form-data)

3) Get presigned URL
- GET /api/files/{fileName}
Returns a time-limited URL to download the object from S3 directly.

4) Download file (proxy through app)
- GET /api/files/download/{fileName}
Sends the file content with appropriate headers.

5) Delete file
- DELETE /api/files/{fileName}
Returns true if S3 reports a successful deletion.

## SQS integration
- Sending messages: Implemented in SqsService with two methods:
  - sendMessage(String body) → sends to aws.sqs.queue-url (Standard queue)
  - sendOrderedMessage(String messageId, String messageGroupId, String body) → sends to aws.sqs.fifo-queue-url (FIFO)
  You can call these from your own components or tests. There is no dedicated REST endpoint for sending in this project.

- Receiving messages: Spring Cloud AWS SQS listeners in SqsService:
  - @SqsListener("#{ '${standardQueueName}' }") → logs messages from the Standard queue
  - @SqsListener("#{ '${fifoQueueName}' }") → logs messages from the FIFO queue
- Manual polling (alternative to the listener): SqsService.pollMessages() long-polls the Standard queue every 5 s with ReceiveMessage and deletes each message. Off by default; set aws.sqs.manual-polling.enabled=true to turn it on (SqsPollingConfig enables scheduling). Both read the same queue, so with polling on they share its messages.

To test receiving, publish messages to the configured queues using the AWS Console or AWS CLI. The application log will show received messages.

## Secrets Manager and Parameter Store
ExternalServiceSecretManager (secrets package):
- getExternalServiceSecrets() → reads the JSON secret named by externalServiceSecrets and maps it to ExternalServiceSecrets
- getParameter(name, decrypt) → reads one SSM parameter, optionally decrypting a SecureString
- getParametersByPath(prefix) → reads all parameters under a path, recursively

## AWS credentials and permissions
The SDK uses the default credentials provider chain. Ensure the configured identity has permissions for:
- s3:PutObject, s3:GetObject, s3:DeleteObject for the target bucket
- sqs:SendMessage, sqs:ReceiveMessage, sqs:DeleteMessage for the configured queues
- secretsmanager:GetSecretValue for the secret; ssm:GetParameter, ssm:GetParametersByPath (and kms:Decrypt for SecureString)

## Troubleshooting
- 403/AccessDenied: Verify bucket policy/IAM permissions and that your credentials are loaded.
- 404 on download: Confirm the object key exists in the bucket.
- SQS listener not receiving: Check queue names in application.properties, queue region, and that the app has permission and is connected to the same account/region.
- Large uploads: Adjust spring.servlet.multipart.max-file-size and max-request-size.

## Notes
- The project is for RnD purposes. Set aws.region (or AWS_REGION) to use a different region.

