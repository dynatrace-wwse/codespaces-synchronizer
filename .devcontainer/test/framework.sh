#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/test/testfunctions.sh

printInfoSection "Running integration Tests for the Enablement FrameworkSSS"

#assertDynatraceOperator

#assertDynatraceCloudNative

assertDeployedApp 30100

assertRunningPod todoapp todoapp

assertRunningPod dynatrace activegate

assertRunningPod dynatrace operator

assertRunningPod dynatrace operator

