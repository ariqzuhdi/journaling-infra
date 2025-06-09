output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_eip.journaling_eip.public_ip
}