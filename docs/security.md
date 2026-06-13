# Security Assessment Report

## Phase 6 – DevSecOps

### Task 12: Pipeline Security (SonarQube)

#### Objective

Implement static code analysis and security scanning within the CI/CD pipeline using SonarQube Cloud.

#### Implementation

* Integrated SonarQube Cloud with GitHub Actions.
* Configured project properties using `sonar-project.properties`.
* Added automated code quality checks during every push to the repository.
* Enabled Quality Gate validation.

#### Results

* Repository successfully analyzed by SonarQube Cloud.
* Security vulnerabilities, code smells, and maintainability issues identified.
* Quality Gate evaluation integrated into the pipeline.

#### Evidence

* Screenshot: SonarQube Project Dashboard
* Screenshot: SonarQube Issues Overview
* Screenshot: Successful GitHub Actions Workflow

---

### Task 13: Container Image Security

#### Objective

Perform vulnerability assessment of container images stored in Amazon Elastic Container Registry (ECR).

#### Implementation

* Built Docker image for the application.
* Pushed image to Amazon ECR.
* Enabled ECR vulnerability scanning.
* Performed image scan using Amazon Inspector integration.

#### Scan Results

| Severity      | Count |
| ------------- | ----- |
| Critical      | 1     |
| High          | 8     |
| Medium        | 4     |
| Low           | 2     |
| Informational | 0     |

Total Vulnerabilities: 15

#### Critical Finding

**CVE-2026-34182**

Affected Package:

* openssl:3.5.6-r0

Severity:

* Critical

Description:
The vulnerability affects OpenSSL cryptographic message processing and may allow attackers to bypass validation mechanisms under specific conditions.

#### Mitigation Strategy

1. Upgrade OpenSSL package to the latest patched version.
2. Rebuild the container image.
3. Push the updated image to ECR.
4. Re-run vulnerability scanning.
5. Integrate automated image scanning within CI/CD pipelines.
6. Use minimal base images to reduce attack surface.

#### Future Improvements

* Integrate Trivy image scanning in GitHub Actions.
* Block deployments containing Critical vulnerabilities.
* Implement periodic vulnerability scanning.
* Use container image signing and verification.

#### Evidence

* Screenshot: ECR Scan Summary
* Screenshot: Vulnerability Details
* Screenshot: Vulnerability Severity Breakdown
