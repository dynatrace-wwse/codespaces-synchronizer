#!/bin/bash
# ======================================================================
#          ------- Custom Functions -------                            #
#  Space for adding custom functions so each repo can customize as.    # 
#  needed.                                                             #
# ======================================================================

customFunction(){
  printInfoSection "This is a custom function that calculates 1 + 1"

  printInfo "1 + 1 = $(( 1 + 1 ))"

}

exposeUnguard(){
  
  getNextFreeAppPort true
  PORT=$(getNextFreeAppPort)
  if [[ $? -ne 0 ]]; then
    printWarn "Application can't be deployed"
    return 1
  fi

  #PORT=30100
  kubectl patch service unguard-envoy-proxy --namespace=unguard --patch="{\"spec\": {\"type\": \"NodePort\", \"ports\": [{\"port\": 8080, \"nodePort\": $PORT }]}}"
  #PORT2=30200
  #kubectl patch service unguard-frontend --namespace=unguard --patch="{\"spec\": {\"type\": \"NodePort\", \"ports\": [{\"port\": 80, \"nodePort\": $PORT2 }]}}"
}

deployUnguard(){

  printInfoSection "Deploying Unguard"
  getNextFreeAppPort true
  PORT=$(getNextFreeAppPort)
  if [[ $? -ne 0 ]]; then
    printWarn "Application can't be deployed, all NodePorts are busy"
    return 1
  fi

  if [[ "$ARCH" != "x86_64" ]]; then
    printWarn "This version of the Unguard only supports AMD/x86 architectures and not ARM, exiting deployment..."
    return 1
  fi
  

  printInfo "Unguard repository https://github.com/dynatrace-oss/unguard/"
  printInfo "A copy of the source files -> /unguard"

  printInfo "Adding bitnami chart ..."
  helm repo add bitnami https://charts.bitnami.com/bitnami

  printInfo "Installing unguard-mariadb ..."
  #helm install unguard-mariadb bitnami/mariadb --version 12.0.2 --set primary.persistence.enabled=false --wait --namespace unguard --create-namespace

  helm install unguard-mariadb bitnami/mariadb \
  --version 11.5.7 \
  --set primary.persistence.enabled=false \
  --set image.repository=bitnamilegacy/mariadb \
  --namespace unguard --create-namespace

  printInfo "Installing Unguard"
  helm install unguard  oci://ghcr.io/dynatrace-oss/unguard/chart/unguard --version 0.12.0 --namespace unguard 

  kubectl patch service unguard-envoy-proxy --namespace=unguard --patch="{\"spec\": {\"type\": \"NodePort\", \"ports\": [{\"port\": 8080, \"nodePort\": $PORT }]}}"

}

undeployUnguard() {

  printInfoSection "Undeploying Unguard"

  helm uninstall unguard -n unguard
  helm uninstall unguard-mariadb -n unguard

}


