#!/usr/bin/env bash
IFS=$'\n\t'

. ./includes/setup.inc.sh

set -euo pipefail

pushd projects/demo-1

rm -rf artifacts/
clear

echo "$ mvn package"
read

mvn --file pom.xml clean package --quiet

echo "# Preserve built artifacts"
mkdir -p artifacts/build-1
cp target/*.jar artifacts/build-1/

echo "$ mvn package"
read

mvn --file pom.xml clean package --quiet

echo "# Preserve built artifacts"
mkdir -p artifacts/build-2
cp target/*.jar artifacts/build-2/

echo "# Compare built artifacts from both builds"
echo "$ diff artifacts/build-1/demo-1.jar artifacts/build-2/demo-1.jar"
diff artifacts/build-1/demo-1.jar artifacts/build-2/demo-1.jar || true

#echo "# Compare built artifacts using Diffoscope"
#echo "diffoscope artifacts/build-1/demo-1.jar artifacts/build-2/demo-1.jar"
#diffoscope artifacts/build-1/demo-1.jar artifacts/build-2/demo-1.jar

popd