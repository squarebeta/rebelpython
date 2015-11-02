#!/bin/bash

PROJECT=${1} &&
    REPOSITORY=${2} &&
    RMAJOR=${3} &&
    RMINOR=${4} &&
    RPATCH=$(git describe --tags --long | grep "^v${RMAJOR}.${RMINOR}-[0-9]*-.*\$" | sed -e "s#^v${RMAJOR}.${RMINOR}-\([0-9]*\)-.*\$#\1#") &&
    RELEASE=${RMAJOR}.${RMINOR}.${RPATCH} &&
    VMAJOR=${5} &&
    VMINOR=${6} &&
    if [ -d build/src/${PROJECT}/${REPOSITORY} ]
    then
	cd build/src/${PROJECT}/${REPOSITORY} &&
	    git fetch origin master &&
	    git rebase origin/master &&
	    true
    else
	mkdir --parents build/src/${PROJECT} &&
	    cd build/src/${PROJECT} &&
	    git clone git@github.com:${PROJECT}/${REPOSITORY}.git &&
	    cd ${REPOSITORY} &&
	    true
    fi &&
    VPATCH=$(git describe --tags --long | grep "^v${VMAJOR}.${VMINOR}-[0-9]*-.*\$" | sed -e "s#^v${VMAJOR}.${VMINOR}-\([0-9]*\)-.*\$#\1#") &&
    VERSION=${VMAJOR}.${VMINOR}.${VPATCH} &&
    cd ../../../.. &&
    cp --recursive build/src/${PROJECT}/${REPOSITORY} build/src/${PROJECT}/${REPOSITORY}-${VERSION} &&
    tar --create --file build/src/${PROJECT}/${REPOSITORY}-${VERSION}.tar --directory build/src/${PROJECT}/${REPOSITORY}-${VERSION} . &&
    gzip -9 --to-stdout  build/src/${PROJECT}/${REPOSITORY}-${VERSION}.tar >  build/src/${PROJECT}/${REPOSITORY}-${VERSION}.tar.gz &&
    mkdir --parents build/spec/${PROJECT} &&
    echo "AAAAAAA 1" &&
    sed -e "s#\${VERSION}#${VERSION}#" -e "s#\${RELEASE}#${RELEASE}#" -e "wbuild/spec/${PROJECT}/${REPOSITORY}.spec" spec/${PROJECT}/${REPOSITORY}.spec &&
    echo "AAAAAAA 2" &&
    ls build/spec/${PROJECT}/${REPOSITORY}.spec &&
    ls build/src/${PROJECT}/${REPOSITORY} &&
    mkdir --parents build/results/${PROJECT}/${REPOSITORY}/buildsrpm/${VERSION}/${RELEASE} &&
    mock --buildsrpm --spec build/spec/${PROJECT}/${REPOSITORY}.spec --sources build/src/${PROJECT} --resultdir build/results/buildsrpm/${PROJECT}/${REPOSITORY}/${VERSION}/${RELEASE} &&
    mkdir --parents build/results/rebuild/${PROJECT}/${REPOSITORY}/${VERSION}/${RELEASE} &&
    mock --rebuild build/results/buildsrpm/${PROJECT}/${REPOSITORY}/${VERSION}/${RELEASE}/${REPOSITORY}-${VERSION}-${RELEASE}.src.rpm --resultdir build/results/rebuild/${PROJECT}/${REPOSITORY}/${VERSION}/${RELEASE} &&
    true
