#!/usr/bin/env bash
IFS=$'\n\t'

. ./includes/setup.inc.sh

set -euo pipefail

pushd projects/demo-2

clear
echo ""
echo "# Check the build plan for the project"
echo "$ mvn artifact:check-buildplan"
read
mvn artifact:check-buildplan

popd