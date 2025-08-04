#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/test/testfunctions.sh

printInfoSection "Running integration tests for the framework"


waitForAllReadyPods todoapp

printInfo "test Dynatrace Deployment"

testDynatrace

printInfo "Testing TODO App"