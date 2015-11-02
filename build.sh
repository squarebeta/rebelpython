#!/bin/bash

PROJECT=${1} &&
    REPOSITORY=${2} &&
    MAJOR=${3} &&
    MINOR=${2} &&
    mkdir --parents build/src/${PROJECT} &&
    cd build/src/${PROJECT} &&
    git clone git@github.com:${PROJECT}/${REPOSITORY}.git &&
    PATCH=$(git describe --tags --long | grep "^v${MAJOR}.${MINOR}-[0-9]*-.*\$" | sed -e "s#^v${MAJOR}.${MINOR}-\([0-9]*\)-.*\$#\1#") &&
    VERSION=${MAJOR}.${MINOR}.${PATCH} &&
    cd ../../.. &&
    mkdir --parents build/spec/${PROJECT} &&
    sed -e "s#\${VERSION}#${VERSION}#" -e "wspec/${REPOSITORY}-${VERSION}.spec" spec/${PROJECT}/${REPOSITORY}.spec &&
    mock --buildsrpm --spec build/spec/${PROJECT}/${REPOSITORY}-${VERSION}.spec --sources build/src/${PROJECT}/${REPOSITORY} &&
    true
