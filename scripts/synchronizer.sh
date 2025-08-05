#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.

# Import functions locally, send errors to dev/null since the path is different as in CS.
source ../.devcontainer/util/variables.sh >/dev/null 2>&1
source ../.devcontainer/util/functions.sh >/dev/null 2>&1



ROOT_PATH="$(dirname $(dirname "$PWD"))/"
SYNCH_REPO="codespaces-synchronizer"

echo "Using the following path '$ROOT_PATH' as root path"

all_repos=("enablement-codespaces-template" "enablement-live-debugger-bug-hunting" "enablement-gen-ai-llm-observability" "enablement-business-observability" "enablement-dql-301" "enablement-dynatrace-log-ingest-101" "enablement-kubernetes-opentelemetry" "enablement-browser-dem-biz-observability")
cs_repos=("enablement-codespaces-template" "enablement-live-debugger-bug-hunting" "enablement-gen-ai-llm-observability" "enablement-business-observability" "enablement-dynatrace-log-ingest-101" "enablement-browser-dem-biz-observability")

fetchAll() {
    doGitActionInRepos all fetch
}

pullAll() {
    doGitActionInRepos all pull
}

pushAll() {
    doGitActionInRepos all push
}

statusAll() {
    doGitActionInRepos all status
}

fetch() {
    doGitActionInRepos cs fetch --all
}

pull() {
    doGitActionInRepos cs pull --all
}

push() {
    doGitActionInRepos cs push
}

status() {
    doGitActionInRepos cs status
}

doGitActionInRepos() {
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Git $2 in $1 repos from $ROOT_PATH$SYNCH_REPO"
    for repo in "${all_repos[@]}"; do
        printInfo "Git $2 in repo $repo "
        cd $ROOT_PATH"$repo" >/dev/null
        git $2 $3
        cd - >/dev/null
    done
}

# Function to compare files in arrays,
# $1[cs or all for iterating in only CS or ALL repos]
# $2=filepath
compareFile() {
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Comparing $2 from $ROOT_PATH$SYNCH_REPO"
    for repo in "${array[@]}"; do

        diff "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2" >/dev/null
        if [ $? -eq 0 ]; then
            printInfo "$repo - $2 =="
        else
            printInfo "$repo - $2 !="
            code --diff "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2" >/dev/null
        fi
    done
}

# Function to compare files in arrays,
# $1[cs or all for iterating in only CS or ALL repos]
# $2=filepath
copyFile() {
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Comparing $2 with ${array[@]}"
    for repo in "${array[@]}"; do
        printInfo "copy $2 in repo $repo "
        cp "$ROOT_PATH$SYNCH_REPO/$2" "$ROOT_PATH$repo/$2"
    done
}

cherryPick() {
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

helperFunction() {
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    printInfoSection "Doing something in repo from this as base $ROOT_PATH$SYNCH_REPO"
    for repo in "${array[@]}"; do
        printInfo "in repo $repo "
        cd $ROOT_PATH"$repo" >/dev/null
        #ls -las
        #git remote add synchronizer https://github.com/dynatrace-wwse/codespaces-synchronizer
        #git fetch synchronizer
        #git checkout main
        #git cherry-pick --abort
        #git status
        #git cherry-pick --abort
        git checkout main
        git fetch --all
        git pull --all
        #git checkout synch/553c7fb
    
        #echo "grep log for $repo --> git log --all | grep 553c7fb"
        #git log --all | grep 553c7fb
        #echo "-------"

        cd - >/dev/null
    done
}

doInRepos() {
    local array_name="$1_repos"
    eval "local array=(\"\${$array_name[@]}\")"
    # Pass the function name as an argument
    func_name=$2
    printInfoSection "Iterating in array ($1) with function($2) with argument $3 tied to $ROOT_PATH$SYNCH_REPO"
    
    for repo in "${array[@]}"; do
        printInfo "for $repo do $2  - $@ "
        # go to repo
        cd $ROOT_PATH"$repo" >/dev/null

        # Call the function using indirect expansion
        $func_name $3 $4 $5 $6 $7 $8

        # go back to previous directory
        cd - >/dev/null
    done
}


cherryPickMerge() {
    # Add synchronizer as remote repo
    git remote | grep -q '^synchronizer$'
    if [ $? -eq 0 ]; then
        # Synchronizer exists, pruning it to avoid conflicts
        git remote prune synchronizer
    else
        git remote add synchronizer https://github.com/dynatrace-wwse/codespaces-synchronizer
    fi
    # fetch synchronizer
    git fetch synchronizer

    # go to main and create branch from there
    git checkout main

    # create branch with merge id
    git checkout -b "synch/$1"

    git cherry-pick -m 1 $1
    if [ $? -eq 0 ]; then
        printInfo "$repo - $1 ->CherryPick OK"
    else
        printInfo "$repo - $1 ->CherryPick NOK"
    fi

}

#doInRepos cs ls -las
#fetch
#doInRepos cs git pull --all 

#doInRepos cs git pull --all

#doInRepos cs git checkout main

#doInRepos cs git log | grep 553c7fb

#doInRepos cs cherryPickMerge 4308a5c
# git checkout main
# git checkout -b synch/8417e91
# git cherry-pick 8417e91

helperFunction cs
#fetchAll
#pullAll
#statusAll

# compareFile cs .devcontainer/util/functions.sh


#fetchAll
#pullAll
#helperFunction cs

## -- History of Cherries
# Merge branch 'ghactions/main'
#cherryPickMerge 89a77e9

# Merge branch 'fix/mkdocs'
# cherryPickMerge be10c91

# Merge branch 'framework/main'
# cherryPickMerge 553c7fb

# rfe/verifycodespace
# cherryPickMerge 8bc2279

# fix/dynakubes
#cherryPickMerge fc755a6

# Astroshop
#cherryPick cs 1c1db04

# TravelAdvisor
#cherryPick cs a02927c

#copyFile cs .devcontainer/util/functions.sh
#compareFile cs docs/snippets/disclaimer.md
# grep -i -E 'error|failed'
