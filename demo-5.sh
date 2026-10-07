#!/usr/bin/env bash
IFS=$'\n\t'

. ./includes/setup.inc.sh

set -euo pipefail

pushd projects/demo-5
cp -Rv . "$CWD/.downloads/reproducible-central/content"
popd

pushd "$CWD/.downloads/reproducible-central"

clear
echo "# Actual .buildspec for my Clocky project"
echo "# (See https://github.com/mthmulders/clocky if you're curious)"
cat content/it/mulders/clocky/clocky/clocky-0.4.16.buildspec
read

echo "# Verify we can rebuild it from source"
echo "$ ./rebuild.sh content/it/mulders/clocky/clocky/clocky-0.4.16.buildspec"
./rebuild.sh content/it/mulders/clocky/clocky/clocky-0.4.16.buildspec

popd

#popd