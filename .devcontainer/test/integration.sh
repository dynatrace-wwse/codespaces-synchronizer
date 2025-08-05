#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/test/test_functions.sh

printInfoSection "Running integration Tests for the Enablement Framework"

assertRunningPod dynatrace operator

assertRunningPod dynatrace activegate

assertRunningPod dynatrace oneagent

assertRunningPod todoapp todoapp

# Print out the logs of the todoApp
kubectl logs -n todoapp -l app=todoapp --all-containers=true

assertRunningApp 30100
