#!/usr/bin/env bash

CWD=$(pwd)
MAVEN_VERSION="3.9.16"

mkdir -p $CWD/.downloads

function __debug() {
  echo ${@}
}

# See if Apache Maven is already downloaded
if [ -f "$CWD/.downloads/apache-maven-$MAVEN_VERSION/bin/mvn" ]; then
  __debug "Found Apache Maven $MAVEN_VERSION at $CWD/.downloads/apache-maven-$MAVEN_VERSION/bin/mvn"
else
  __debug "Apache Maven $MAVEN_VERSION not found at $CWD/.downloads/apache-maven-$MAVEN_VERSION/bin/mvn"
  pushd "$CWD/.downloads" || exit 1
  __debug "Downloading Apache Maven $MAVEN_VERSION"
  curl -L -O https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
  tar -xzf apache-maven-$MAVEN_VERSION-bin.tar.gz
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz
  popd
fi

# Create a `mvn` function to use the downloaded Maven 3.x
function mvn() {
  "$CWD/.downloads/apache-maven-$MAVEN_VERSION/bin/mvn" "$@"
}

# Workaround for macOS to run Diffoscope.
# Diffoscope relies on `zipdetails` but the version that macOS ships is very outdated.
# That's why the demo runs it in a Debian container.
# See salsa.debian.org/reproducible-builds/diffoscope/-/work_items/429 for details.
if [[ "$OSTYPE" == "darwin"* ]]; then

    # Prepare Docker container with Diffoscope for current architecture
    __debug "Building Diffoscope Docker image"
    pushd ./diffoscope
    docker build -t diffoscope:latest .
    popd

    # Create a `diffoscope` function to use the Dockerized Diffoscope
    function diffoscope() {
      docker run --rm -t -w $(pwd) -v $(pwd):$(pwd):ro diffoscope:latest "$@"
    }

fi

export CLIENT_KEY=correct-horse-battery-staple