#!/bin/sh

# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
set -e

echo "Build OHTTPStubs $1"

maxXcodeVersion=1100
swiftVersion="5.0"
buildPlatform=$1

if [ ${XCODE_VERSION_ACTUAL} -lt ${maxXcodeVersion} ]
then
    #xcode 10
    swiftVersion="4.2"
fi

# workaround for the problem on xcode 10: https://stackoverflow.com/questions/52987843/carthage-fails-to-start-when-running-from-xcode-10-build-pre-action/53136006
unset LLVM_TARGET_TRIPLE_SUFFIX

# xcodebuild path
xcodebuild \
 -workspace ../Vendor/OHHTTPStubs/OHHTTPStubs.xcworkspace \
 -scheme "OHHTTPStubs ${buildPlatform} Framework" \
 -sdk iphonesimulator \
 -configuration Debug ONLY_ACTIVE_ARCH=NO SWIFT_VERSION=${swiftVersion} \
 clean build CONFIGURATION_BUILD_DIR="../${buildPlatform}/OHHTTPStubs"
