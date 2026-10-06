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

mkdir -p artifacts/build-1
cp target/*.jar artifacts/build-1/

echo "$ mvn package"
read

mvn --file pom.xml clean package --quiet

mkdir -p artifacts/build-2
cp target/*.jar artifacts/build-2/

echo "# Print SHA-256 sums of built artifacts"
find artifacts/ -type f -name "demo*.jar" -exec sha256sum {} \;

popd