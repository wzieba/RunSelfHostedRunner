#!/bin/bash -x
GH_RUNNER_VERSION="2.276.0"

curl -L "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-osx-x64-${GH_RUNNER_VERSION}.tar.gz" >actions.tar.gz
tar -zxf actions.tar.gz
rm -f actions.tar.gz
