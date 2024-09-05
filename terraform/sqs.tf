resource "aws_sqs_queue" "test_event" {
  name                       = "Test_Event.fifo"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 60 
  receive_wait_time_seconds  = 0
  
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.test_dlq.arn,
    maxReceiveCount     = 3
  })

  fifo_queue                  = true
  deduplication_scope         = "messageGroup"
  fifo_throughput_limit       = "perMessageGroupId"
  content_based_deduplication = true
  sqs_managed_sse_enabled = false
}

resource "aws_sqs_queue" "test_dlq" {
  name                              = "Test_Event_DLQ.fifo"
  message_retention_seconds         = 345600
  visibility_timeout_seconds        = 30
  max_message_size                  = 262144


  fifo_queue                  = true
  deduplication_scope         = "messageGroup"
  fifo_throughput_limit       = "perMessageGroupId"
  content_based_deduplication = true
  sqs_managed_sse_enabled = false
}

