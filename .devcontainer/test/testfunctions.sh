#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/util/functions.sh

testDynatrace(){

    printInfoSection "Testing dynatrace deployment"
    kubectl get all -n dynatrace 
    exit 0
}

testDynatraceFailed(){

    printInfoSection "Testing dynatrace deployment"
    kubectl get all -n dynatrace 
    exit 1
}


testDeployedApp(){
    printInfoSection "Testing Deployed app in PORT $1"
    kubectl get all -n dynatrace 

    curl -v http://localhost:30100 | grep -q "todo" && echo "TODO App Running" || echo "TODO App Not Running"
    printError "failed exiting with 1"
    exit 1
}