#!/bin/sh

# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
set -e

echo "Build OHTTPStubs $1"

# maxXcodeVersion = 1100
swiftVersion="5.0"
buildPlatform=$1

if [ ${XCODE_VERSION_ACTUAL} -lt 1100 ]
then
    #xcode 10
    swiftVersion="4.1"
fi

cd ../Vendor/OHHTTPStubs
# rake "build_carthage_frameworks[${buildPlatform},${swiftVersion}]"
rake "build_carthage_frameworks[iOS,4.1]"
# cp -R "Vendor/OHHTTPStubs/Carthage/Build/${buildPlatform}/OHHTTPStubs.framework" "../../Vendor/${buildPlatform}/Hello145"
