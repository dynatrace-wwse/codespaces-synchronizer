#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.
source synchronizer/synch_functions.sh

export TITLE="Copying core framework before release v1.0.1"
export BODY="Enhance codespace tracker information.
- Add core framework
- Add RUM 
- Fix sed -i issue on mounted volumes 
- Add ARM automatic deployment of DT OA and AG
- Add shields
- Update RUNME
- Bump Dynakube "

export CHERRYPICK_ID="47b1d0f"

export TAG="v1.0.1"
export RELEASE="$TAG"

#export BRANCH=synch/$CHERRYPICK_ID
export BRANCH="cleanup/housekeeping"

# Flags for copyFramework
export EXCLUDE_MKDOC=true
export EXCLUDE_CUSTOMFILES=true

printInfoSection "Running Codepaces-Synchronizer"


custom(){
    # Custom function to be able to run commands in all CS repos.
    #repo=$(basename $(pwd))
    #printInfoSection "Running custom action in repo $repo"
    
    # Show last release
    #L=$(gh release list --limit 1)
    #printInfo "$L"


    #git reset --hard HEAD
    #git checkout main
    #git clean -fd
    #git pull origin main
    #git status
    #git checkout $BRANCH
    git status
    #git remote -v
    # git pull --all

    #git branch -D $BRANCH
    ## Cleaning for main
    #git checkout main
    #git pull origin main
    #git checkout -b monitoring/main
    #git pull --all
    #git status
    #git add .
    #git commit -s -m "Bump RUNME to 3.13.2"
    #git push origin

}

gh api \
  --method PUT \
  /repos/dynatrace-wwse/codespaces-synchronizer/branches/main/protection \
  --input - <<EOF
{
  "required_status_checks": {
    "strict": true,
    "contexts": [
      "codespaces-integration-test-with-dynatrace-deployment"
    ]
  },
  "enforce_admins": true,
  "allow_deletions": false,
  "required_pull_request_reviews": null,
  "restrictions": null
}
EOF



#doInRepos all custom

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

