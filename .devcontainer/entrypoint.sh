#!/bin/bash
# entrypoint.sh
source /workspaces/$RepositoryName/.devcontainer/util/functions.sh

echo "Entrypoint loaded with args: $@"
# Function is defined in functions.sh
entrypoint $@