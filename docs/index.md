--8<-- "snippets/index.js"

??? example "[![dt-badge](https://img.shields.io/badge/powered_by-DT_enablement-8A2BE2?logo=dynatrace)](https://dynatrace-wwse.github.io/codespaces-synchronizer)"
    This codespace is powered by the Dynatrace Enablement Framework, this means that this codespace:

      - can run in github codespaces, as a remote container or locally as docker container
      - is crosscompiled for AMD and ARM architectures
      - follows a set of standards and best practices for enhancing the user experience
    
    Want to learn more about it? We invite you to read [this documentation](https://dynatrace-wwse.github.io/codespaces-template)

<p align="center">
  <img src="img/framework_banner.png" alt="DT Enablement Framework">
</p>


## Project Goals

??? tip "The goal of this effort"
    **Reduce complexity, remove friction and increase adoption of the Dynatrace Platform**

    The Dynatrace Enablement Framework is a structured set of tooling and best practices designed to streamline how we deliver, maintain, and scale solutions across the Dynatrace Platform. Its core purpose is to increase platform adoption by ensuring consistent training delivery, comprehensive solution coverage, and operational efficiency.Trainings within the framework are built as GitHub Codespaces—they’re publicly accessible, run seamlessly across environments, and adhere to a defined set of standards to ensure quality, repeatability, and alignment across teams.


## <img src="https://cdn.bfldr.com/B686QPH3/at/w5hnjzb32k5wcrcxnwcx4ckg/Dynatrace_signet_RGB_HTML.svg?auto=webp&format=pngg" alt="DT logo" width="22"> Dynatrace Enablement Framework in a Nutshell

The Dynatrace Enablement Framework streamlines the delivery of demos and hands-on trainings for the Dynatrace Platform. It provides a unified set of tools, templates, and best practices to ensure trainings are easy to create, run anywhere, and maintain over time.

### ✅ Key Features

- **GitHub-Hosted & Versioned**  
  All trainings are managed in GitHub repositories, ensuring traceability and collaboration.

- **Self-Service Documentation**  
  Each repo includes its own MkDocs-powered documentation, published via GitHub Pages.

- **Universal Base Image**  
  A Docker image supports AMD/ARM architectures, GitHub Codespaces, VS Code Dev Containers, and contaninerized execution in any Ubuntu OS.

- **Separation of Concerns**  
  Modular design allows repo-specific logic without impacting the core framework.

- **Automated Testing**  
  GitHub Actions enable end-to-end integration tests for all trainings.

- **Monitoring & Analytics**  
  Usage and adoption are tracked with Dynatrace for continuous improvement.

- **Rapid Training Creation**  
  Templates and automation help trainers launch new enablement content quickly.

- **Centralised Maintenance**  
  The Codespaces Synchronizer tool keeps all repositories up to date with the latest framework changes.

---

### Benefits
- Reduces complexity and friction for trainers and learners  
- Increases adoption and consistency  
- Scales across internal, partner, and customer enablement


!!! tip "What will we do"
    In this tutorial we will learn how easy it is to create an enablement using codespaces and a Kubernetes cluster!

### Support Policy
--8<-- "snippets/disclaimer.md"


<div class="grid cards" markdown>
- [Yes! let's begin :octicons-arrow-right-24:](container-image.md)
</div>