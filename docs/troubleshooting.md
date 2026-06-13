## Task 14: Pipeline Debugging

### Issue

The SonarQube GitHub Actions pipeline failed during the DevSecOps stage.

### Failure Symptoms

The workflow failed in the SonarQube scan / Quality Gate stage with errors such as:

- Automatic Analysis is enabled while CI analysis is running
- Quality Gate check returned HTTP 403
- Pipeline exited with code 3

### Root Cause Analysis

The failure occurred due to SonarCloud analysis configuration conflict and Quality Gate access issues.

The project had SonarCloud Automatic Analysis enabled while the repository was also running analysis through GitHub Actions. This caused a conflict because SonarCloud does not allow both Automatic Analysis and CI-based analysis at the same time.

Additionally, the separate Quality Gate GitHub Action caused authorization issues with SonarCloud and returned HTTP 403.

### Fix Implemented

The following corrective actions were applied:

1. Disabled Automatic Analysis in SonarCloud.
2. Kept GitHub Actions as the main analysis method.
3. Added `sonar-project.properties` at repository root.
4. Configured correct SonarCloud project key and organization.
5. Simplified the GitHub Actions workflow to use the SonarQube scan action.
6. Removed the failing separate Quality Gate action.

### Validation

After applying the fix, the SonarQube scan completed successfully in GitHub Actions.

### Evidence

- Failed pipeline screenshot
- Error log screenshot
- SonarCloud analysis method screenshot
- Successful pipeline screenshot