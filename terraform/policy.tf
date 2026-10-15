resource "aws_sqs_queue_policy" "test_event_sqs_policy" {
  queue_url = aws_sqs_queue.test_event.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqs_policy_1",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
          "AWS": [
            "${aws_iam_role.event_bridge_sqs_role.arn}"
          ]
        },
      "Action": ["sqs:SendMessage", "sqs:ReceiveMessage"],
      "Resource": "${aws_sqs_queue.test_event.arn}"
    }
  ]
}
POLICY
}


resource "aws_sqs_queue_policy" "test_event_dlq_sqs_policy" {
  queue_url = aws_sqs_queue.test_dlq.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqs_policy_2",
  "Statement": [
    {
      "Sid": "Second",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["sqs:SendMessage", "sqs:ReceiveMessage"],
      "Resource": "${aws_sqs_queue.test_dlq.arn}"
    }
  ]
}
POLICY
}
