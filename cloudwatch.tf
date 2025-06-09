resource "aws_cloudwatch_metric_alarm" "cpu_usage_alarm" {
  alarm_name          = "High CPU Usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    InstanceId = aws_instance.journaling-instance.id
  }

  alarm_description = "This alarm triggers when CPU usage exceeds 80% for two consecutive periods."

  tags = {
    Name = "High CPU Usage Alarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  alarm_name          = "high-memory-journaling"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "30"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors high memory usage"
  dimensions = {
    InstanceId = aws_instance.journaling-instance.id
  }
}
