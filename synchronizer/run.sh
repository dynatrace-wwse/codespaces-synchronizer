#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.
source synchronizer/synch_functions.sh

export TITLE="Enhance Framework before release v1.0.0"
export BODY="Enhance codespace tracker information. fix sed -i issue on mounted volumes, Add ARM automatic deployment of DT OA and AG, Add shields, Add RUM, Update RUNME "
export CHERRYPICK_ID="47b1d0f"

#export BRANCH=synch/$CHERRYPICK_ID
export BRANCH="copycore/tracker"

# Flags for copyFramework
export EXCLUDE_MKDOC=true
export EXCLUDE_CUSTOMFILES=true

printInfoSection "Running Codepaces-Synchronizer"


custom(){
    # Custom function to be able to run commands in all CS repos.
    repo=$(basename $(pwd))
    printInfoSection "Running custom action in repo $repo"
    ## Resetting
    printInfo "Listing the PRs"

    #copyFramework
    
    #git reset --hard HEAD
    #git clean -f
    #git branch -D $BRANCH

    ## Cleaning for main
    #git checkout main
    #git pull origin main
    #git checkout -b monitoring/main
    #git pull --all
    #git status
    #git add .
    #git commit -s -m "Bump RUNME to 3.13.2"
    #git push origin $BRANCH
    #gh pr list
    # We list the PRs and only the one from the PR branch we get the ID
}


#doInRepos cs verifyPrMerge

#doInRepos cs custom
#doInRepos cs custom

#doInRepos cs doPushandPR

#doInRepos cs copyFramework


#doInRepos cs mergePr
#doInRepos cs git status


#helperFunction cs

#doInRepos cs git status
# compareFile cs .devcontainer/util/functions.sh


#fetchAll
#pullAll
#helperFunction cs

## -- History of Cherries

# Merge branch 'fix/path'
#cherryPickMerge 47b1d0f

# Merge branch 'ghactions/nohist'
#cherryPickMerge 8417e91

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

