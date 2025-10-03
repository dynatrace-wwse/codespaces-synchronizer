#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.
source synchronizer/synch_functions.sh

export TITLE="Miscelaneus changes"
export BODY="Miscelaneus changes, adding functions for ease of use 
- calculateReadingTime
- checkHost 
"

export CHERRYPICK_ID="47b1d0f"

export TAG="v1.0.1"
export RELEASE="$TAG"

#export BRANCH=synch/$CHERRYPICK_ID
export BRANCH="rfe/mcp-server"

# Flags for copyFramework
export EXCLUDE_MKDOC=true
export EXCLUDE_CUSTOMFILES=false
export IMPORT=true

printInfoSection "Running Codepaces-Synchronizer"

custom(){  
    
    #TODO for this PR
    # [y] - npm and node to the image
    # [y] - bump image
    # [ ] - devcontainer.json description of env
    # [ ] - dt-banner (all) -> MCP server
    # [ ] - tenant -> environment
    # [ ] - add MCP Server func.


    repo=$(basename $(pwd))
    printInfo "Custom function for repository $repo "


    #rm .github/workflows/github-test-cs.yaml.back
    
    # For importing changes we invert
    #DEST="$ROOT_PATH$SYNCH_REPO/"
    #SOURCE="$ROOT_PATH$repo/"
    
    #SOURCE="$ROOT_PATH$SYNCH_REPO/"
    #DEST="$ROOT_PATH$repo/"
    #FILE="docs/snippets/dt-enablement.md"
    #cp "$SOURCE$FILE" "$DEST$FILE"
    #git status
    #git checkout main
    #git pull origin main
    #git status
    #git checkout -b $BRANCH
    git add .
    git commit -s -m "$BODY"
    #git status
    #doPushandPR
    #gh issue list --state open
    #git push origin $BRANCH 

    # Show last release
    #L=$(gh release list --limit 1)
    #printInfo "$L"
    #git reset --hard HEAD
}

#doInRepos refactor custom

doInRepos unguard copyFramework
#doInRepos synch listOpenIssues
#doInRepos synch verifyPrMerge

#doInRepos fix tagAndCreateRelease
#doInRepos fix copyFramework
#doInRepos synch copyFramework 


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

