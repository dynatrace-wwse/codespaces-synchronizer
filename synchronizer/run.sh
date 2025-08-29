#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.
source synchronizer/synch_functions.sh

export TITLE="Housekeeping, cleaning code, branches, enhance workflows after release v1.0.1"
export BODY="Housekeeping, cleaning code, remove merged branches, enhance workflows after release v1.0.1:
- Removing unnecesary files
- Adding more ports for local docker 
- print warning when running on ARM and deploying DT components since they are not latest
- main branch is protected, integration test needed for merging
- ghpages get updated on every merge on main "

export CHERRYPICK_ID="47b1d0f"

export TAG="v1.0.1"
export RELEASE="$TAG"

#export BRANCH=synch/$CHERRYPICK_ID
export BRANCH="rfe/housekeeping"

# Flags for copyFramework
export EXCLUDE_MKDOC=true
export EXCLUDE_CUSTOMFILES=true

printInfoSection "Running Codepaces-Synchronizer"


custom(){
    # Custom function to be able to run commgands in all CS repos.
    repo=$(basename $(pwd))
    printInfoSection "Housekeeping - $repo"
    
    # Show last release
    #L=$(gh release list --limit 1)
    #printInfo "$L"

    #rm .devcontainer/runlocal/README
    #rm .devcontainer/runlocal/power10k.sh
    #rm -rf .devcontainer/astroshop

    #git reset --hard HEAD
    #git checkout main
    #git pull origin main
    #git status
    #git clean -fd
    #git pull origin main
    #git status
    #git checkout -b $BRANCH
    git add .
    git commit -s -m "$TITLE"
    #git restore README.md
    #git status
    #git checkout main
    #git pull origin main
    #git pull --all
    #git status
    #git remote remove synchronizer
    #git fetch --all
    #echo "$(git branch -a)"

    #git branch -D $BRANCH
    ## Cleaning for main
    #git checkout main
    #git pull origin main
    #git checkout -b monitoring/main
    #git pull --all
    #git add .
    #git status
    #git push origin
}


doInRepos this doPushandPR
doInRepos all generateMarkdowntable
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

