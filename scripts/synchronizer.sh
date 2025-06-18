#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.

# Import functions locally, send errors to dev/null since the path is different as in CS.
source ../.devcontainer/util/variables.sh >/dev/null 2>&1
source ../.devcontainer/util/functions.sh >/dev/null 2>&1

ROOT_PATH="/Users/sergio.hinojosa/repos/enablement/"
SYNCH_REPO="codespaces-synchronizer"

all_repos=("enablement-codespaces-template" "enablement-live-debugger-bug-hunting"  "enablement-gen-ai-llm-observability" "enablement-business-observability" "enablement-dql-301" "enablement-dynatrace-log-ingest-101" "enablement-kubernetes-opentelemetry")
cs_repos=("enablement-codespaces-template" "enablement-live-debugger-bug-hunting"  "enablement-gen-ai-llm-observability" "enablement-business-observability" "enablement-dynatrace-log-ingest-101")


fetchAll(){
    doGitActionInRepos all fetch
}

pullAll(){
    doGitActionInRepos all pull
}

pushAll(){
    doGitActionInRepos all push
}

statusAll(){
    doGitActionInRepos all status
}

fetch(){
    doGitActionInRepos cs fetch
}

pull(){
    doGitActionInRepos cs pull
}

push(){
     doGitActionInRepos cs push
}

status(){
    doGitActionInRepos cs status
}

doGitActionInRepos(){
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Git $2 in $1 repos from $ROOT_PATH$SYNCH_REPO"
    for repo in "${all_repos[@]}"; do
        printInfo "Git $2 in repo $repo "
        cd $ROOT_PATH"$repo" >/dev/null
        git $2 
        cd - >/dev/null
    done
}

# Function to compare files in arrays, 
# $1[cs or all for iterating in only CS or ALL repos] 
# $2=filepath 
compareFile(){
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Comparing $2 from $ROOT_PATH$SYNCH_REPO"
    for repo in "${array[@]}"; do
        
        diff "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2" > /dev/null
        if [ $? -eq 0 ]; then
            printInfo "$repo - $2 =="
            else
            printInfo "$repo - $2 !="
            code --diff "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2" > /dev/null
        fi
    done   
}

# Function to compare files in arrays, 
# $1[cs or all for iterating in only CS or ALL repos] 
# $2=filepath 
copyFile(){
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Comparing $2 with ${array[@]}"
    for repo in "${array[@]}"; do
        printInfo "copy $2 in repo $repo "
        cp "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2"
    done   
}

cherryPick(){
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Merging commit $2 from $ROOT_PATH$SYNCH_REPO"
    for repo in "${array[@]}"; do
        cd $ROOT_PATH"$repo" >/dev/null
        #git remote add synchronizer https://github.com/dynatrace-wwse/codespaces-synchronizer
        git fetch synchronizer
        #git checkout -b synch
        git cherry-pick $2
        if [ $? -eq 0 ]; then
            printInfo "$repo - $2 ->CherryPick OK"
            else
            printInfo "$repo - $2 ->CherryPick NOK"
        fi

        cd - >/dev/null
    done
}

#fetchAll
#pullAll
#statusAll

compareFile cs .devcontainer/util/functions.sh

# Astroshop
#cherryPick cs 1c1db04

# TrvelAdvisor
#cherryPick cs a02927c

#copyFile cs .devcontainer/util/functions.sh
#compareFile cs docs/snippets/disclaimer.md
# grep -i -E 'error|failed'