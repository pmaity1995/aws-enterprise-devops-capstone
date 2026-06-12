output "cluster_name" {
  value = aws_eks_cluster.capstone.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.capstone.endpoint
}

output "vpc_id" {
  value = aws_vpc.capstone_vpc.id
}