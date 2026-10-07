#!/usr/bin/env bash
IFS=$'\n\t'

. ./includes/setup.inc.sh

set -euo pipefail

pushd projects/demo-2

# Build a version and install it locally, simulating that SLF4J 2.0.20 is not yet released.
# The config.properties file is in Cp1252 encoding (converted using `iconv -t Cp1252 src/main/resources/config.properties`)
# which goes against the specs, but since the user who built it uses that as a platform encoding, the build did not fail.
rm -Rf -Rf ~/.m2/repository/org/slf4j/slf4j-api/2.0.20/
JAVA_TOOL_OPTIONS=-Dfile.encoding=Cp1252 CLIENT_KEY=correct-horse-battery-staple mvn --file pom.xml clean install --offline --quiet > /dev/null 2>&1

echo ""
echo "# Compare local build with the reference build"
read 
echo "$ mvn clean verify artifact:compare -Dreference.repo=file://${HOME}/.m2/repository/"
mvn clean verify artifact:compare -Dreference.repo=file://${HOME}/.m2/repository/ -Dgpg.skip=true -Dcompare.fail=false

echo ""
echo "# Inspect target/demo-2-1.0-SNAPSHOT.buildcompare"
read
cat target/demo-2-1.0-SNAPSHOT.buildcompare

echo ""
echo "# Compare the built JAR against the reference one"
echo "$ diffoscope target/reference/it.mulders.deterministicbydesign/demo-2-1.0-SNAPSHOT.jar target/demo-2.jar"
read
diffoscope target/reference/it.mulders.deterministicbydesign/demo-2-1.0-SNAPSHOT.jar target/demo-2.jar

popd