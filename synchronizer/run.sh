#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.
source synchronizer/synch_functions.sh

export TITLE="Add applications repository, housekeeping, enhanced greeting after v1.0.1"
export BODY="Add applications repository, housekeeping, enhanced greeting after v1.0.1
- Adding applications repository
- NodePort allocation is dynamic
- helper function deployApp to deploy/undeploy apps 
- enhanced greeting, dynamically show information
- tests functions loaded in framework "

export CHERRYPICK_ID="47b1d0f"

export TAG="v1.0.1"
export RELEASE="$TAG"

#export BRANCH=synch/$CHERRYPICK_ID
export BRANCH="rfe/apps"

# Flags for copyFramework
export EXCLUDE_MKDOC=true
export EXCLUDE_CUSTOMFILES=false

printInfoSection "Running Codepaces-Synchronizer"

custom(){  
    
    #TODO for this PR
    # [] - delete    .github/workflows/github-test-cs.yaml.back
    # [y] - Copy functions.sh file from Template repo - Done
    # [y] - Migrate my_functions.sh from https://github.com/dynatrace-wwse/workshop-dynatrace-log-analytics
    # [y] - Log analytics, verify repo, add ports, kind, etc...
    # [y] - Copy test_functions.sh to all repos (no source)
    # [y] - Copy integration.sh and add repo and remove loading
    # [y] - Copy kind.yaml 
    # [y] - Verify ports also on json devcontainer 
    # [ ] - Add this to all repos with the file --8<-- "snippets/dt-enablement.md"
    # [y] - change badge to all repos to point to the documentation of synchronizer

    repo=$(basename $(pwd))
    printInfo "Custom function for repository $repo "

    #git checkout -b $BRANCH
    #git status

    #rm .github/workflows/github-test-cs.yaml.back
    #SOURCE="$ROOT_PATH$SYNCH_REPO/"
    #DEST="$ROOT_PATH$repo/"
    # For importing changes we invert
    #DEST="$ROOT_PATH$SYNCH_REPO/"
    #SOURCE="$ROOT_PATH$repo/"
    #FILE="docs/snippets/dt-enablement.md"
    #cp "$SOURCE$FILE" "$DEST$FILE"
    #git add .
    #git status

    git commit -s -m "adding enablement info for pointing to documentation"
    git push origin $BRANCH 

    # Show last release
    #L=$(gh release list --limit 1)
    #printInfo "$L"

    #rm .devcontainer/runlocal/README
    #rm .devcontainer/runlocal/power10k.sh
    #rm -rf .devcontainer/astroshop

    #git reset --hard HEAD
}

#doInRepos refactor custom

#doInRepos synch doPushandPR
doInRepos synch verifyPrMerge
#doInRepos synch custom


#doInRepos all generateMarkdowntable
#doInRepos all custom
#doInRepos all doPushandPR

#doInRepos all copyFramework
#doInRepos all deleteBranches
#doInRepos all copyFramework

#doInRepos migrate tagAndCreateRelease

#doInRepos migrate verifyPrMerge

#doInRepos migrate doPushandPR

#doInRepos migrate copyFramework

#doInRepos migrate custom

#doInRepos cs custom

#doInRepos cs verifyPrMerge

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

