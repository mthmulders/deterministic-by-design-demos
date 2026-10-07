# Deterministic by Design: Achieving Reproducible Builds with Maven

This repository contains all the demo's for "Deterministic by Design: Achieving Reproducible Builds with Maven"

## Prerequisites

* You need Mac OS or Linux.
* You need Bash.
* You need Docker.
* You need to have an `amd64` or `arm64` processor.
* You need [diffoscope](https://diffoscope.org/) installed - except on macOS, [see below](#macos-note).

## Preparations

Make sure to have a Java 21 runtime installed and ready for use.
The scripts assume that an environment variable `JAVA_HOME` exists and points to the installation directory of a Java 21 runtime.

## Running the demos

To play a particular demo, use the `demo-<n>.sh` script.

### macOS note

If you are on macOS, be prepared that the first time, it may take quite a while.
This is because the script builds a Docker container to run Diffoscope.
Details are in [./includes/setup.inc.sh](**./includes/setup.inc.sh**).
