resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/eks/capstone-eks"
  retention_in_days = 7
}