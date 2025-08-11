#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.
source synchronizer/synch_functions.sh

export TITLE="Core Framework functionality v0.1"
export BODY="Merging changes of core functionality to make sure all CherryPicks have been copied. Using git diff to verify no functionality is left out."
export CHERRYPICK_ID="47b1d0f"
#export BRANCH=synch/$CHERRYPICK_ID
export BRANCH="copycore/V0.1"

printInfo "Testing Synch"


#doInRepos cs copyFramework


#doInRepos cs doPushandPR
#doInRepos cs mergePr
#doInRepos cs git status


helperFunction cs

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

