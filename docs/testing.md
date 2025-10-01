--8<-- "snippets/testing.js"

!!! example "Quality Assurance"
	To maintain high standards across all repositories using the enablement framework, a robust testing strategy is enforced. This ensures that every repository remains reliable, consistent, and production-ready.

## 🧪 Integration Testing on Pull Requests

- **Automated Integration Tests:**  
  Every repository must have integration tests that run automatically on every Pull Request (PR). This guarantees that new changes do not break existing functionality.

- **integration.sh:**  
  The core of the testing process is the `integration.sh` script. This script is adapted for each repository and is triggered by a GitHub Actions workflow on every PR.  
  - The workflow provisions a full Codespace environment, deploying all required applications and dependencies.
  - Once the environment is ready, `integration.sh` runs a series of assertions to verify that applications and pods are running as expected in their respective namespaces.

- **On-Demand Testing:**  
  Integration tests can also be executed manually at any time using the `runIntegrationTests` function, providing flexibility for developers to validate changes before submitting a PR.

## 🔒 Branch Protection

- **Main Branch Protection:**  
  The `main` branch is protected and will only accept PRs that pass all integration tests. This ensures that only thoroughly tested code is merged, maintaining the integrity of the repository.

---

## 🛡️ Integration Test Badges

All repositories in the enablement framework display an **integration test badge** to show the current status of their automated tests. This badge provides immediate visibility into the health of each repository.

For example, the badge for this repository is:

![Integration tests](https://github.com/dynatrace-wwse/codespaces-framework/actions/workflows/integration-tests.yaml/badge.svg)

You can find a table with all enablement framework repositories and their current integration test status in the [README section of this repository](https://github.com/dynatrace-wwse/codespaces-framework).

---

By following these standards, the enablement framework enforces continuous quality assurance and reliability across all managed repositories.

<div class="grid cards" markdown>
- [Let's continue:octicons-arrow-right-24:](monitoring.md)
</div>