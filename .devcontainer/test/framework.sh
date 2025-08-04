#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/test/testfunctions.sh

printInfoSection "Running integration Tests for the Enablement Framework"

testDynatraceOperator

testDynatraceCloudNative

testDeployedApp 30100

