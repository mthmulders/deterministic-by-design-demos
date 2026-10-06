#!/usr/bin/env bash
IFS=$'\n\t'

. ./includes/setup.inc.sh

set -euo pipefail

pushd projects/demo-4

echo ""
echo "# Check the build plan for the project"
echo "$ mvn artifact:check-buildplan"
read
mvn artifact:check-buildplan

echo ""
echo "# Build and install the project on the other team members laptop"
read

# Build a version and install it locally, simulating that SLF4J 2.0.20 is not yet released.
# The config.properties file is in Cp1252 encoding (converted using `iconv -t Cp1252 src/main/resources/config.properties`)
# which goes against the specs, but since the user who built it uses that as a platform encoding, the build did not fail.
JAVA_TOOL_OPTIONS=-Dfile.encoding=Cp1252 mvn --file pom.xml clean install --offline --quiet > /dev/null 2>&1

echo ""
echo "# Compare local build with the reference build"
read 
echo "$ mvn clean verify artifact:compare -Dreference.repo=file://${HOME}/.m2/repository/"
mvn clean verify artifact:compare -Dreference.repo=file://${HOME}/.m2/repository/ -Dgpg.skip=true -Dcompare.fail=false

echo "# Inspect target/demo-4-1.0-SNAPSHOT.buildcompare"
read
cat target/demo-4-1.0-SNAPSHOT.buildcompare

popd