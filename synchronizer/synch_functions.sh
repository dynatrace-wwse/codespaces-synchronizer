#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.

source .devcontainer/util/source_framework.sh

ROOT_PATH="$(dirname "$PWD")/"
SYNCH_REPO=$RepositoryName

printInfo "Using as ROOT_PATH: $ROOT_PATH"
printInfo "This is synchronization repo: $SYNCH_REPO"


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


# Function to copy all files from one repository to another. A branch will be created and 
# the diff will show the difference between files so no functionality gets lost.
copyFramework(){
    repo=$(basename $(pwd))

    printInfoSection "Copying core files to repository $repo into branch $BRANCH"

    git checkout main
    git pull origin main
    git checkout -b $BRANCH

    cp "$ROOT_PATH$SYNCH_REPO/.gitignore" "$ROOT_PATH$repo/.gitignore"
    cp -R "$ROOT_PATH$SYNCH_REPO/.devcontainer/" "$ROOT_PATH$repo/.devcontainer/"
    cp -R "$ROOT_PATH$SYNCH_REPO/.github/" "$ROOT_PATH$repo/.github/"
    
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
        
        #git reset --hard HEAD
        #git branch -D $BRANCH
        git add .devcontainer/apps
        #git checkout main 
        #git pull 
        git status
        #rm -rf .devcontainer/apps

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
    
    repo=$(basename $(pwd))

    printInfoSection "Doing CherryPick Merge for $repo with Cherry: $CHERRYPICK_ID"
    printInfo "PR '$TITLE'. '$BODY'"

    # go to main and create branch from there
    git checkout main

    # get latest changes
    git pull 

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

    # create branch with merge id
    git checkout -b "synch/$CHERRYPICK_ID"

    git cherry-pick -m 1 $CHERRYPICK_ID
    if [ $? -eq 0 ]; then
        printInfo "$repo - $CHERRYPICK_ID ->CherryPick OK"

        doPushandPR
    else
        printInfo "$repo - $1 ->CherryPick NOK"
    fi

}

doPushandPR(){
    repo=$(basename $(pwd))

    printInfo "Pushing $BRANCH for $repo"
    git push origin $BRANCH
    
    printInfo "creating PR for dynatrace-wwse/$repo"
    gh repo set-default dynatrace-wwse/$repo
    
    gh pr create --base main --head $BRANCH --title "$TITLE" --body "$BODY"

    printWarn "A PR will be created with an URL, next step is to Merge the PR automatically if the check is ok."

}

mergePr(){
    repo=$(basename $(pwd))
    printInfo "Merging synch/$CHERRYPICK_ID for $repo"
    git pull origin main
    git checkout main
    git merge synch/$CHERRYPICK_ID
    git push -u origin main
}