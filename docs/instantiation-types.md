--8<-- "snippets/instantiation-types.js"

!!! success "Choose the option that best fits your needs! 🚀" 
    The Dynatrace Enablement Framework supports multiple ways to instantiate your development environment. You can run it in Github Codespaces, VS Code Dev Containers or local containers, in AMD or ARM architectures.  


## 🏃🏻‍♂️ Quick step by step guide on running in...

### 1. Running in ☁️ GitHub Codespaces ![run codespace](img/run_codespace.png){ align=right ; width="300"} 
1. Go to the repository hosted in github
2. Click on the **<> Code** button. 
3. Create a new codespace using the main branch or click + New with options to customize how and where to run the Codespace within Github Cloud. 


_Repository Secrets normally `DT_TENANT`, `DT_OPERATOR_TOKEN` and `DT_INGEST_TOKEN` (but not limited to) are injected automatically using GitHub Codespaces secrets. No manual setup required — these are available as environment variables inside the container._


### 2. 📦 Running in VS Code Dev Containers or Local Container

??? info "Key difference between instantiating a VS Code Dev Container or a local container"
     The key difference between instantiating a VS Code Dev Container and a local container lies in how each environment is created and managed: a VS Code Dev Container is launched and orchestrated directly by VS Code using the configuration specified in the devcontainer.json file, while a local container is started independently using the Makefile and runlocal script, allowing you to build and manage the container from the terminal without relying on VS Code, which is ideal for headless or automated workflows.

The following set of instructions are for the preparation of both scenarios.

1. The first step is to provide the infrastructure. 
	
	??? info "🏗️ Setting up the infrastructure" 
		You may provision your infrastructure on any major cloud provider or run locally using [Multipass](#using-multipass-for-local-development).

		**Minimum requirements for a cloud or local machine:**
    
		1. **Operating System:** Ubuntu LTS (22.04 or 24.04 recommended)
		2. **CPU & Memory:** The required resources depend on your workloads. As a general guideline, refer to the `hostRequirements` section in the `.devcontainer.json` file. A typical setup with 4 CPU cores and 16 GB RAM is sufficient for most use cases.
		3. **Network Ports:** Ensure the following ports are open for inbound connections:
			- `22` (SSH)
			- `30100`, `30200`, `30300` (for application access; each deployed app is exposed via Kubernetes NodePort)

2. SSH into the host

3. Clone the git repository

4. Setting up the secrets: 
	Make sure the secrets are defined as environment variables. **VS Code** needs to read the secrets as an environment variable, and the **local container** approach does not need VS Code. Hence we create a file under `.devcontainer/runlocal/.env` that works for both approaches.

	??? info "Sample `.env` file"
		You can copy and paste the contents of the sample into `.devcontainer/runlocal/.env`. Verify that you have entered all needed secrets for the training. These are defined in the `secrets` section of the .devcontainer.json` file. If the repository does not need secrets, just create an empty `.env` file.

		```bash title=".devcontainer/runlocal/.env" linenums="1"
		# Environment variables

		# Mapping of the Secrets defined in the .devcontainer.json file
		# Dynatrace Tenant
		DT_TENANT=https://abc123.apps.dynatrace.com

		# Dynatrace Operator Token
		DT_OPERATOR_TOKEN=dt0c01.XXXXXX
		#it will be created automatically when adding a new Cluster over the UI. It contains the following permissions: 'Create ActiveGate tokens' 'Read entities' 'Read settings' 'Write settings' 'Access probrem and event feed, metrics and topology' 'PaaS Integration - installer download

		#Dynatrace Ingest Token
		DT_INGEST_TOKEN=dt0c01.YYYYYY
		# it will be created automatically when adding a new Cluster over the UI. It contains the following permissions: 'Ingest logs' 'Ingest metrics' 'Ingest OpenTelemetry traces'

		# Add any other environment variables as needed
		```

5. Prerequisites: `make` and `docker` is installed on the host and the user has access to it.
	
	??? info "Verify prerequisites with `checkHost`"
		There is a sample function that helps you verify the requirements are met and if not it offers to install them for you if needed. 
		```bash
		source .devcontainer/util/source_framework.sh && checkHost
		```
		![checkhost](img/checkhost.png){ align=center ; width="800";} 


!!! success "Le't's launch the enablement"
	You are all set, we can launch the enablement either with `VS Code` as a dev container or with `make` as a plain docker container.


#### 2. a. 📦 🖥️ Running as dev container with VS Code 

1. Let's tell VS Code to read the secrets as environment variables from an `.env`file. Modify the `runArgs` in `.devcontainer/devcontainer.json` and add `"--env-file", ".devcontainer/runlocal/.env"`like the following:
	```json
	"runArgs": ["--init", "--privileged", "--network=host", "--env-file", ".devcontainer/runlocal/.env"]
	```
- This ensures all variables in `.devcontainer/runlocal/.env` are available inside the container.
- ![run codespace](img/vscode_container.png){ align=right ; width="400"}Open the folder in VS Code and use the Dev Containers extension to "Reopen in Container". VS Code will use the `.devcontainer/devcontainer.json` definition to build and start the environment for you.
- You can rebuild the container at any time by typing ```[CTRL] + Shift P > Dev Containers: Rebuild and reopen in container```

#### 2. b. 📦 🐳 Running as local container with make
1. Navigate to `.devcontainer` folder and run:
	```sh
	make start
	```
- This will build and launch the container. All ports, volumes, and environment variables are set up automatically.
	
	!!! info "Protip: create a new Terminal"
		For attaching a new Terminal to the container, just type `make start`.

- Secrets and environment variables are loaded from `.devcontainer/runlocal/.env`. 
- The `makefile.sh` script passes the variables to Docker at runtime such as arguments, volume mounts and port-forwarding. The devcontainer.json file is not used with this set-up.


## Instantiation Types 
### 1. ☁️ GitHub Codespaces

- **One-click cloud dev environments**  
- No local setup required—just click  
- [Learn more about Codespaces](https://github.com/features/codespaces)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?template_repository=dynatrace-wwse/codespaces-framework)

### 2. 🖥️ VS Code Dev Containers

- Use the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for a seamless local experience in VS Code
- All configuration is in `.devcontainer/devcontainer.json`
- Supports secrets, port forwarding, and post-create hooks


### 3. 🐳 Local Container

- Run the same environment on your machine using Docker.
- Easiest way: just run `make start` in the `.devcontainer` folder.
- This will build and launch the container if needed, or attach to it if already running.
- All ports, volumes, and environment variables are set up for you automatically.



## ⚡ Quick Comparison

| Type                  | Runs On              | VS Code Needed | Fast Start | Customizable | Secrets Handling | Port Forwarding | Best For                  |
|-----------------------|:--------------------:|:--------------:|:----------:|:------------:|:---------------:|:---------------:|---------------------------|
| ☁️ Codespaces         | GitHub Cloud         | ❌             | ✅         | ❌           | Auto-injected   | Auto            | Quick onboarding, demos   |
| 🖥️ VS Code DevContainer | Provided Infrastructure | ✅             | ✅         | ✅           | Auto/manual     | Auto            | Full-featured local dev   |
| 🐳 Local Container    | Provided Infrastructure | ❌             | ✅         | ✅           | Manual/`.env`   | Manual/Makefile | Reproducible local dev    |


## 🔐 Secrets & Environment

Secrets and environment variables are handled differently depending on the instantiation type:

| Instantiation Type         | How Secrets Are Provided                                                                 | Where to Configure/Set                        | Notes                                                                                 |
|---------------------------|----------------------------------------------------------------------------------------|-----------------------------------------------|---------------------------------------------------------------------------------------|
| ☁️ Codespaces             | Auto-injected as environment variables from GitHub Codespaces secrets                   | GitHub repository > Codespaces secrets         | No manual setup; secrets available at container start                                 |
| 🖥️ VS Code Dev Containers | Passed as environment variables via `runArgs` and `.env` file                          | `.devcontainer/devcontainer.json`, `.devcontainer/runlocal/.env`      | Edit/add `.devcontainer/runlocal/.env` for local secrets; `runArgs` must include `--env-file`                    |
| 🐳 Local Container        | Loaded from `.devcontainer/runlocal/.env` file and passed to Docker at runtime by `makefile.sh`                | `.devcontainer/runlocal/.env`, `makefile.sh`   | Run `make start` in `.devcontainer`; secrets loaded at container start                |




---

## 🏠 Running locally

### Using Multipass for Local Development

[Multipass](https://multipass.run/) is a lightweight VM manager from Canonical that makes it easy to launch and manage Ubuntu virtual machines on macOS, Windows, and Linux. This is especially useful if you want to run the framework in a clean, reproducible Ubuntu environment without dual-booting or using a full desktop VM.

**Why use Multipass?**

- Ensures compatibility with Ubuntu-based dev containers and scripts
- Isolates your development environment from your host OS
- Quick to launch, easy to reset or remove

#### Basic usage

  -  **Install Multipass** ([instructions](https://multipass.run/install)) 
  -  **Launch an Ubuntu VM:**
	```sh
	multipass launch --name enablement --disk 30G --cpus 8 --memory 32G
	multipass shell dt-dev
	```

!!! tip "Mounting Volumes on Multipass"
    You can mount folders from your host into the VM using `multipass mount` if you want to edit code locally but run containers in the VM. For example in the following example we are creating a VM mounting the folder `enablement` where you have all repositories of the enablement framework you want to use. 
    ```bash
    multipass launch --name enablement --disk 30G --cpus 8 --memory 32G --mount  /Users/sergio.hinojosa/repos/enablement:/home/ubuntu/enablement
    ```

<div class="grid cards" markdown>
- [Let's continue:octicons-arrow-right-24:](template.md)
</div>