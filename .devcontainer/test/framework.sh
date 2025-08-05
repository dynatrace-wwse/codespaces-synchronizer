#!/bin/bash
source /workspaces/$RepositoryName/.devcontainer/test/testfunctions.sh

printInfoSection "Running integration Tests for the Enablement Framework"

assertRunningApp 30100

assertRunningPod todoapp todoapp

assertRunningPod dynatrace operator

assertRunningPod dynatrace activegate

assertRunningPod dynatrace oneagent

