#!/bin/bash
# entrypoint.sh
source /workspaces/$RepositoryName/.devcontainer/util/functions.sh

echo "ARGUMENTS $@"
# Function is defined in functions.sh
entrypoint $@