#!/bin/bash

PROJECT=${1} &&
    REPOSITORY=${2} &&
    RMAJOR=${3} &&
    RMINOR=${4} &&
    RPATCH=$(git describe --tags --long | grep "^v${RMAJOR}.${RMINOR}-[0-9]*-.*\$" | sed -e "s#^v${RMAJOR}.${RMINOR}-\([0-9]*\)-.*\$#\1#") &&
    RELEASE=${RMAJOR}.${RMINOR}.${RPATCH} &&
    VMAJOR=${5} &&
    VMINOR=${6} &&
    mkdir --parents build/src/${PROJECT} &&
    cd build/src/${PROJECT} &&
    git clone git@github.com:${PROJECT}/${REPOSITORY}.git &&
    VPATCH=$(git describe --tags --long | grep "^v${VMAJOR}.${VMINOR}-[0-9]*-.*\$" | sed -e "s#^v${VMAJOR}.${VMINOR}-\([0-9]*\)-.*\$#\1#") &&
    VERSION=${VMAJOR}.${VMINOR}.${VPATCH} &&
    cd ../../.. &&
    mkdir --parents build/spec/${PROJECT} &&
    sed -e "s#\${VERSION}#${VERSION}#" -e "wspec/${REPOSITORY}-${VERSION}.spec" spec/${PROJECT}/${REPOSITORY}.spec &&
    mock --buildsrpm --spec build/spec/${PROJECT}/${REPOSITORY}-${VERSION}.spec --sources build/src/${PROJECT}/${REPOSITORY} &&
    true