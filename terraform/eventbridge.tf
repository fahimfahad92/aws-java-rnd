resource "aws_scheduler_schedule" "every_5_minutes" {
  name       = "every-5-minutes"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(5 minutes)"

  target {
    arn      = aws_sqs_queue.test_event.arn
    role_arn = aws_iam_role.event_bridge_sqs_role.arn
	sqs_parameters {
      message_group_id = "test-grp-id"
    }
  
  input = jsonencode({
   MessageBody = "{\"key\":\"value\"}"
  }) 
  
  retry_policy {
	maximum_retry_attempts = 3
  }
 
  }
  
  
}