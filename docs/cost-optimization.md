# Cost Optimization Report

## Overview

This report analyzes the AWS infrastructure used for the AWS Enterprise DevOps Capstone Project and identifies opportunities for cost optimization.

Services reviewed:

- Amazon EKS
- Amazon EC2
- Amazon EBS
- Amazon ECR
- Amazon CloudWatch
- Amazon VPC

---

## Cost Explorer Analysis

Cost Explorer was reviewed for the Mumbai (ap-south-1) region.

Observations:

- Total cost reported: $0.00
- Average daily cost: $0.00
- Services monitored:
  - Amazon EKS
  - Amazon EC2
  - Amazon ECR
  - Amazon CloudWatch
  - EC2 Other

### Screenshot

Insert Cost Explorer screenshot here.

---

## Trusted Advisor Review

Trusted Advisor was reviewed.

Observations:

- Cost Optimization recommendations require a higher AWS Support Plan.
- No cost-related recommendations were available under the current support tier.

A security recommendation was identified regarding unrestricted security group access.

### Screenshot

Insert Trusted Advisor screenshot here.

---

## Infrastructure Review

### EKS Cluster

Current Configuration:

- Node Group: capstone-workers-v2
- Instance Type: t3.small
- Desired Nodes: 1
- Minimum Nodes: 1
- Maximum Nodes: 2

Cost Optimization Assessment:

The cluster is already running on a small instance type suitable for development and testing workloads.

Recommendation:

- Keep desired capacity at 1 node during development.
- Scale only when additional workloads are required.
- Consider Spot Instances for non-production environments.

Expected Benefit:

- Lower EC2 compute costs.

### Screenshot

Insert EKS Node Group screenshot here.

---

### EC2 Instances

Current Configuration:

- Instance Type: t3.small
- Running as EKS worker node

Optimization Opportunities:

- Stop unused instances.
- Use Auto Scaling for dynamic workloads.
- Continue using t3.small for development workloads.

Expected Benefit:

- Reduced compute costs.

### Screenshot

Insert EC2 Instance screenshot here.

---

### EBS Volumes

Current Configuration:

- Volume Type: gp3
- Size: 20 GiB

Optimization Opportunities:

- Regularly review storage usage.
- Delete unused volumes and snapshots.
- Maintain gp3 storage instead of more expensive alternatives.

Expected Benefit:

- Reduced storage costs.

### Screenshot

Insert EBS Volume screenshot here.

---

### NAT Gateway Review

Current Configuration:

- No NAT Gateway deployed.

Cost Impact:

NAT Gateways generate fixed hourly charges and data processing charges.

Assessment:

No action required.

This configuration already avoids unnecessary NAT Gateway costs.

### Screenshot

Insert NAT Gateway screenshot here.

---

### Amazon ECR

Current Configuration:

- Container images stored in ECR.

Optimization Opportunities:

- Configure Lifecycle Policies.
- Automatically delete old image versions.
- Retain only recent image tags.

Expected Benefit:

- Reduced storage costs.

---

### CloudWatch

Current Configuration:

- Monitoring and logs collected for the application.

Optimization Opportunities:

- Reduce log retention period.
- Delete unnecessary log groups.
- Archive older logs if required.

Expected Benefit:

- Reduced logging and monitoring costs.

---

## Cost Optimization Recommendations Summary

| Service | Recommendation | Expected Benefit |
|----------|---------------|------------------|
| EKS | Keep node count minimal | Lower compute cost |
| EC2 | Use t3.small instances | Reduced instance cost |
| EBS | Remove unused volumes | Lower storage cost |
| ECR | Configure lifecycle policies | Lower image storage cost |
| CloudWatch | Reduce retention period | Lower logging cost |
| NAT Gateway | Avoid deployment unless required | Avoid monthly NAT charges |

---

## Conclusion

The AWS infrastructure used for the capstone project is already relatively cost efficient.

Key positive findings include:

- Small EKS worker node configuration
- No NAT Gateway deployed
- Limited EBS storage allocation
- No significant AWS charges recorded during the review period

Additional savings can be achieved through ECR lifecycle policies, CloudWatch log retention tuning, and maintaining minimal EKS node capacity.

The current architecture balances functionality, scalability, and cost efficiency for a development environment.