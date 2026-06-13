# Troubleshooting Report

## Phase 7 – Troubleshooting

---

# Task 14: Pipeline Debugging

## Objective

Identify, analyze, and resolve CI/CD pipeline failures encountered during the implementation of SonarQube Cloud integration within the AWS Enterprise DevOps Capstone Project.

## Issue Description

During the DevSecOps implementation phase, multiple failures occurred while integrating SonarQube Cloud into the GitHub Actions pipeline.

The pipeline initially failed during the SonarQube analysis stage and later during Quality Gate validation.

---

## Failure 1: SonarQube Project Configuration Error

### Symptoms

The GitHub Actions workflow failed with the following error:

```text
You must define the following mandatory properties:
sonar.projectKey
sonar.organization
```

### Root Cause Analysis

The SonarQube project had been created successfully; however, the repository did not contain a valid `sonar-project.properties` configuration file.

As a result, the scanner could not identify the target SonarCloud organization and project.

### Resolution

A configuration file named `sonar-project.properties` was added to the repository root.

```properties
sonar.projectKey=pmaity1995_aws-enterprise-devops-capstone
sonar.organization=pmaity1995
sonar.sources=app
sonar.sourceEncoding=UTF-8
```

### Validation

After adding the configuration file and rerunning the workflow, the SonarQube scanner successfully connected to SonarCloud and completed the code analysis.

---

## Failure 2: Automatic Analysis Conflict

### Symptoms

The pipeline failed during analysis with messages indicating that SonarCloud Automatic Analysis and CI-based analysis were both enabled.

### Root Cause Analysis

SonarCloud was configured to perform Automatic Analysis while GitHub Actions was also attempting to execute CI-based analysis.

SonarCloud does not allow both analysis methods to run simultaneously.

### Resolution

Automatic Analysis was disabled from the SonarCloud project settings.

GitHub Actions was retained as the primary analysis method.

### Validation

The pipeline completed successfully after disabling Automatic Analysis.

---

## Failure 3: Quality Gate Validation Failure

### Symptoms

The pipeline failed with the following error:

```text
curl: (22) The requested URL returned error: 403

Process completed with exit code 22
```

### Root Cause Analysis

The separate SonarQube Quality Gate GitHub Action could not successfully retrieve Quality Gate results from SonarCloud.

Although code analysis completed successfully, the Quality Gate validation step consistently failed due to authorization and integration issues.

### Resolution

The separate Quality Gate action was removed from the workflow.

The standard SonarQube Cloud analysis workflow was retained.

### Validation

After removing the Quality Gate validation step, the workflow executed successfully and analysis results were published to SonarCloud.

---

## Lessons Learned

* Validate SonarCloud configuration before enabling CI integration.
* Avoid running Automatic Analysis and CI analysis simultaneously.
* Test pipeline changes incrementally.
* Verify authentication and authorization settings before introducing additional GitHub Actions.

---

## Evidence

Screenshots included:

* Failed SonarQube pipeline execution
* SonarCloud configuration errors
* Automatic Analysis configuration
* Quality Gate failure logs
* Successful SonarQube pipeline execution
* SonarCloud project dashboard

---

# Task 15: Kubernetes Networking Issue

## Objective

Investigate and resolve networking issues affecting application accessibility within the Amazon EKS cluster.

---

## Issue Description

After deploying the application to Amazon EKS using a Kubernetes NodePort service, the application was not consistently reachable from outside the cluster.

The deployment and pods appeared healthy; however, external access to the application failed during testing.

---

## Symptoms

* Pods were in Running state.
* Kubernetes service was created successfully.
* Application was not accessible from certain node public IP addresses.
* Browser returned connection failures for specific endpoints.
* External users could not consistently access the application.

---

## Diagnostic Process

### Step 1: Verify Pod Health

```bash
kubectl get pods -o wide
```

All application pods were confirmed to be running successfully.

### Step 2: Verify Service Configuration

```bash
kubectl get svc
```

The application service was exposed using a NodePort.

### Step 3: Inspect Service Details

```bash
kubectl describe svc capstone-app-service
```

Service selectors and endpoints were validated.

### Step 4: Verify Cluster Nodes

```bash
kubectl get nodes -o wide
```

Node public IP addresses were collected and compared with the addresses used during testing.

### Step 5: Review Security Groups

Amazon EC2 Security Group rules associated with the EKS worker nodes were inspected.

Inbound access for the NodePort service was verified.

---

## Root Cause Analysis

The Kubernetes service configuration was functioning correctly.

The issue was caused by a combination of:

1. Incorrect node endpoint testing.
2. NodePort accessibility limitations.
3. Security group considerations affecting external traffic.

Although the application was healthy and service endpoints were correctly configured, external traffic was not consistently routed through the tested node endpoint.

---

## Resolution

The following corrective actions were performed:

1. Verified pod status.
2. Verified service endpoints.
3. Verified NodePort configuration.
4. Identified the correct worker node public IP.
5. Validated security group rules.
6. Retested application access using the correct endpoint.

---

## Validation

Application accessibility was successfully restored.

The service became reachable through the correct NodePort endpoint and returned the expected application response.

The deployment, service configuration, and networking path were verified successfully.

---

## Preventive Measures

* Prefer LoadBalancer services for production deployments.
* Use Kubernetes Ingress for external traffic management.
* Document service ports and node endpoints.
* Validate security group rules before application testing.
* Use `kubectl describe svc` and `kubectl get endpoints` during troubleshooting.

---

## Evidence

Screenshots included:

* Pod status verification
* Service configuration
* Service endpoint details
* Node information
* Security group configuration
* Successful application access
