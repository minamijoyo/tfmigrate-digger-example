#!/bin/bash

set -euo pipefail
#
# pre_workflow_hooks.sh
#
# This script should be run before the digger is executed.
#
# This script does the following:
# - If a pull request includes a migration file, install tfmigrate and replace digger.yml.
#
echo "Start pre_workflow_hooks"

# The following variables are set as built-in variables in GitHub Actions.
echo "GITHUB_REPOSITORY: ${GITHUB_REPOSITORY:?"GITHUB_REPOSITORY is not set."}"
# The following variables must be passed as environment variables.
echo "PR_NUMBER: ${PR_NUMBER:?"PR_NUMBER is not set."}"

TFMIGRATE_VERSION=0.4.1
TFMIGRATE_DOWNLOAD_URL="https://github.com/minamijoyo/tfmigrate/releases/download/v${TFMIGRATE_VERSION}/tfmigrate_${TFMIGRATE_VERSION}_linux_amd64.tar.gz"

echo "Check migration files"
MIGRATION_FILES=$(
  gh api "/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}/files" --paginate |
    jq -r '.[] | select((.status != "removed") and (.filename | startswith("tfmigrate/"))) | .filename'
)

if [[ -n "${MIGRATION_FILES}" ]] ; then
  echo "Install tfmigrate"
  curl -fsSL "$TFMIGRATE_DOWNLOAD_URL" \
    | tar -xzC /usr/local/bin && chmod +x /usr/local/bin/tfmigrate

  echo "tfmigrate version: $(tfmigrate --version)"

  cp digger_tfmigrate.yml digger.yml
else
  echo "Skip migration"
fi

echo "End pre_workflow_hooks"
