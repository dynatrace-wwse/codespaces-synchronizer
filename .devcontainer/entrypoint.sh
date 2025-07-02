#!/bin/bash
# entrypoint.sh
#source /workspaces/$RepositoryName/.devcontainer/util/functions.sh

# FUNCTIONS DECLARATIONS
timestamp() {
  date +"[%Y-%m-%d %H:%M:%S]"
}

printInfo() {
  echo -e "${GREEN}[$LOGNAME| ${BLUE}INFO${CYAN} |$(timestamp) ${LILA}|${RESET} $1 ${LILA}|"
}

printInfoSection() {
  echo -e "${GREEN}[$LOGNAME| ${BLUE}INFO${CYAN} |$(timestamp) ${LILA}|$thickline"
  echo -e "${GREEN}[$LOGNAME| ${BLUE}INFO${CYAN} |$(timestamp) ${LILA}|$halfline ${RESET}$1${LILA} $halfline"
  echo -e "${GREEN}[$LOGNAME| ${BLUE}INFO${CYAN} |$(timestamp) ${LILA}|$thinline"
}

echo "Entrypoint loaded with args: $@"
# Function is defined in functions.sh
entrypoint(){
  printInfoSection "Making sure user permissions, host mapping and docker.sock are mapped correctly"
  if [ true ]; then
    USER=$(whoami)
    printInfo "PID is $$, running as $USER inside the container"
  
    printInfo "Adding containers Hosts to etc/hosts/ for network resolution and sharing"
    # Add hostname to docker container's /etc/hosts
    HOST_MAPPING="127.0.0.1  $(hostname)"
    # We pipe out the output since sudo at this points gives an error due the hostname not being resolvable
    sudo sh -c "echo \"$HOST_MAPPING\" >> /etc/hosts" > /dev/null 2>&1
    # Verify output (optional)
    printInfo "/etc/hosts content:"
    #cat /etc/hosts

    printInfo "Verifying the Hosts Docker.sock GID (DOCKER_SOCK_GID) vs Container Docker Group GID (DOCKER_GROUP_ID)"
    # Even if the user is in the same group (docker) since they are sharing the socket, the GID of the socket needs to match the GID of the docker group in the container.
    # GID from the socker stat
    DOCKER_SOCK_GID=$(stat -c '%g' /var/run/docker.sock)
    # Group ID for docker group
    DOCKER_GROUP_ID=$(getent group docker | cut -d: -f3)
    # Mapping docker groups of Host and Container
    if [ $DOCKER_SOCK_GID = $DOCKER_GROUP_ID ]; then
        printInfo "DOCKER_SOCK_GID[$DOCKER_SOCK_GID] matches DOCKER_GROUP_ID[$DOCKER_GROUP_ID]. No changes needed."
    else
        printInfo "DOCKER_SOCK_GID[$DOCKER_SOCK_GID] do NOT match DOCKER_GROUP_ID[$DOCKER_GROUP_ID]. Updating..."
        sudo groupmod -g $DOCKER_SOCK_GID docker && printInfo "Updated correctly..."

        printInfo "Adding '$USER' to the docker group to have access to the docker socket"
        sudo usermod -aG docker $USER

        printInfo "Changing shell with 'newgrp docker' to apply changes immediately of the docker group membership"
        
        printInfo "Executing following commands as Group docker: 0:$0 ,$1 ,$2, @:$@ , *:$*"
        #exec newgrp docker "$0 $*"
        #exec sg docker "$@"
        #exec sg docker "$0"
        exec sg docker "$*"
        
        # Construct an array which quotes all the command-line parameters.
        #arr=("${@/#/\"}")
        #arr=("${arr[*]/%/\"}")
        #exec sg docker "$0 ${arr[@]}"
        
        #exec newgrp docker "$@"
        printInfo "Replacing current shell process with the command and its arguments passed to the script or function since we are at entrypoint"
        exec "$@"
    fi
  else
    printInfo "PID is not 1, it is $$, nothing to verify, we are not at the entrypoint."
  fi
}


entrypoint $@