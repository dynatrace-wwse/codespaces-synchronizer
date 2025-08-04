#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/util/functions.sh

testDynatraceOperator(){

    printInfoSection "Testing Dynatrace Operator Deployment"
    kubectl get all -n dynatrace
    printWarn "TBD"
}

testDynatraceCloudNative(){

    printInfoSection "Testing Dynatrace CloudNative FullStack deployment"
    kubectl get all -n dynatrace
    kubectl get dynakube -n dynatrace
    printWarn "TBD"
}

testDeployedApp(){
    PORT=30100
    URL="http://localhost:$PORT"
    printInfoSection "Testing Deployed app running in $URL"

    if curl --silent --fail "$URL" > /dev/null; then
        printInfo "✅ App is running on port $PORT"
    else
        printError "❌ App is NOT running on port $PORT"
        exit 1
    fi
}