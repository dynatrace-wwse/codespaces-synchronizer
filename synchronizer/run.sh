#!/bin/bash
# This file contains the functions synchronizing multiple repos and their files, specially the important function files.

source synch_functions.sh

printInfo "testing synch"

#doInRepos cs cherryPickMerge 8417e91
# git checkout main
# git checkout -b synch/8417e91
# git cherry-pick 8417e91

#helperFunction cs
#fetchAll
#pullAll
#statusAll

# compareFile cs .devcontainer/util/functions.sh


#fetchAll
#pullAll
#helperFunction cs

## -- History of Cherries
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

