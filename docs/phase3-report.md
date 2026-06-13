# Phase 3 – Continuous Deployment (CD) Pipeline Report

## Objective

The objective of Phase 3 was to implement a Continuous Deployment (CD) pipeline that automatically deploys application updates to AWS infrastructure after successful code integration.

The deployment workflow was implemented using GitHub Actions, Docker, Amazon Elastic Container Registry (ECR), and Amazon Elastic Kubernetes Service (EKS).

---

# Architecture Overview

The deployment process follows the workflow below:

1. Developer pushes code changes to GitHub.
2. GitHub Actions triggers the CD pipeline.
3. Docker image is built automatically.
4. Docker image is pushed to Amazon ECR.
5. Kubernetes deployment manifests are applied to the EKS cluster.
6. Updated application version is deployed automatically.

---

# Technologies Used

| Component      | Purpose                      |
| -------------- | ---------------------------- |
| GitHub Actions | CI/CD Automation             |
| Docker         | Application Containerization |
| Amazon ECR     | Container Registry           |
| Amazon EKS     | Kubernetes Platform          |
| kubectl        | Kubernetes Deployment Tool   |
| AWS CLI        | AWS Authentication           |

---

# CD Pipeline Workflow

## Step 1: Trigger Deployment

The deployment workflow is triggered when code is pushed to the deployment branch.

GitHub Actions automatically starts the deployment pipeline.

---

## Step 2: Build Docker Image

The application is containerized using Docker.

Example command:

```bash
docker build -t aws-enterprise-devops-capstone .
```

The resulting image contains the complete application and runtime dependencies.

---

## Step 3: Authenticate with Amazon ECR

AWS credentials are securely stored using GitHub Secrets.

The workflow authenticates with Amazon ECR and obtains a temporary login token.

---

## Step 4: Push Image to Amazon ECR

The image is tagged and pushed to the private ECR repository.

Example:

```bash
docker tag app:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/aws-enterprise-devops-capstone:latest

docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/aws-enterprise-devops-capstone:latest
```

Validation:

* Image successfully uploaded to ECR.
* Latest image version visible in the ECR repository.

### Screenshot

Insert ECR Repository Screenshot Here.

---

## Step 5: Deploy to Amazon EKS

The workflow updates Kubernetes resources using:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

This deploys the application pods to the EKS cluster.

Validation:

```bash
kubectl get deployments
kubectl get pods
```

Expected Result:

```text
Deployment Available
Pods Running
```

### Screenshot

Insert Running Pods Screenshot Here.

---

# Challenges Encountered

## EKS Node Group Creation Failure

### Issue

During the initial setup, worker nodes failed to join the cluster.

### Investigation

The node group configuration and permissions were reviewed.

### Resolution

* Recreated the node group.
* Verified IAM roles.
* Confirmed node registration.

Validation:

```bash
kubectl get nodes
```

Expected Result:

```text
Ready
```

### Screenshot

Insert Node Group Screenshot Here.

---

## Kubernetes Service Exposure Issue

### Issue

Initially, the application was configured using a Kubernetes LoadBalancer service.

The service remained in:

```text
EXTERNAL-IP: Pending
```

and no AWS Load Balancer was provisioned.

### Root Cause

The AWS Load Balancer Controller required for automatic LoadBalancer provisioning was not configured in the EKS cluster.

### Investigation Performed

Commands used:

```bash
kubectl get svc
kubectl describe svc
```

Additional checks were performed on:

* EKS networking configuration
* AWS service integration
* Kubernetes service events

### Resolution

To continue deployment validation without introducing additional infrastructure complexity, the service type was changed from:

```yaml
type: LoadBalancer
```

to:

```yaml
type: NodePort
```

This allowed the application to be accessed using:

```text
Node Public IP + NodePort
```

### Benefits

* Simplified deployment validation.
* Eliminated dependency on AWS Load Balancer Controller.
* Enabled successful application testing.

### Validation

Commands used:

```bash
kubectl get svc
kubectl get pods
kubectl get deployments
```

Results:

* Pods running successfully.
* Deployment available.
* Service reachable through NodePort.

### Screenshot

Insert NodePort Service Screenshot Here.

---

# Deployment Validation

The following checks were performed after deployment.

## Verify Nodes

```bash
kubectl get nodes
```

Result:

```text
Ready
```

## Verify Deployments

```bash
kubectl get deployments
```

Result:

```text
Available
```

## Verify Pods

```bash
kubectl get pods
```

Result:

```text
Running
```

## Verify Service

```bash
kubectl get svc
```

Result:

```text
NodePort Service Active
```

---

# Security Considerations

The deployment pipeline follows basic security best practices.

Implemented controls:

* AWS credentials stored in GitHub Secrets.
* Private Amazon ECR repository.
* No hardcoded credentials.
* Kubernetes manifests stored in version control.
* IAM roles used for EKS worker nodes.

---

# Results Achieved

The Continuous Deployment pipeline was successfully implemented.

Achievements:

* Automated Docker image build.
* Automated image push to Amazon ECR.
* Automated Kubernetes deployment.
* Successful deployment to Amazon EKS.
* Secure credential management.
* Application accessibility through NodePort service.
* Repeatable deployment process using GitHub Actions.

---

# Conclusion

Phase 3 successfully established a Continuous Deployment pipeline using GitHub Actions, Amazon ECR, and Amazon EKS.

Although automatic LoadBalancer provisioning was unavailable due to the absence of the AWS Load Balancer Controller, the deployment was successfully validated using a NodePort service.

The final solution provides a reliable and automated deployment workflow that can be extended in future iterations with advanced Kubernetes networking components.
