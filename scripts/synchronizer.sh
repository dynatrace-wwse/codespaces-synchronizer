#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.

# Import functions locally, send errors to dev/null since the path is different as in CS.
source ../.devcontainer/util/variables.sh >/dev/null 2>&1
source ../.devcontainer/util/functions.sh >/dev/null 2>&1

ROOT_PATH="/Users/sergio.hinojosa/repos/enablement/"
SYNCH_REPO="codespaces-synchronizer"

all_repos=("enablement-codespaces-template" "enablement-live-debugger-bug-hunting"  "enablement-gen-ai-llm-observability" "enablement-business-observability" "enablement-dql-301" "enablement-dynatrace-log-ingest-101" "enablement-kubernetes-opentelemetry")
cs_repos=("enablement-codespaces-template" "enablement-live-debugger-bug-hunting"  "enablement-gen-ai-llm-observability" "enablement-business-observability" "enablement-dynatrace-log-ingest-101")


fetchAllRepos(){
    printInfoSection "Fetching all Repos"
    doGitActionInAllRepos "fetch"
}

pullAllRepos(){
    printInfoSection "Pulling all Repos"
    doGitActionInAllRepos "pull"
}

doGitActionInAllRepos(){
    for repo in "${repos[@]}"; do
        printInfo "Git $1 in repo $repo "
        cd $ROOT_PATH"$repo" >/dev/null
        git $1 
        cd -
    done
}

# Function to compare files in arrays, 
# $1[cs or all for iterating in only CS or ALL repos] 
# $2=filepath 
compareFile(){
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Comparing $2 in ${array[@]}"
    for repo in "${array[@]}"; do
        printInfo "comparing $2 in repo $repo "
        
        diff "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2" > /dev/null
        if [ $? -eq 0 ]; then
            echo "Files are identical."
            else
            echo "Files are different"
            code --diff "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2" > /dev/null
            #break
        fi
    done   
}

compareFile cs .devcontainer/util/functions.sh
#compareFile cs docs/snippets/disclaimer.md