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