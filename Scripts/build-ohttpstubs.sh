#!/bin/sh

# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
set -e

echo "Build OHTTPStubs build platform $1 build sdk $2 scheme name $3"

maxXcodeVersion=1100
swiftVersion="5.0"
buildPlatform=$1
buildSdk=$2
buildPlatformScheme=$3

cd ../Vendor/OHHTTPStubs

if [ ${XCODE_VERSION_ACTUAL} -lt ${maxXcodeVersion} ]
then
    # workaround for the problem on xcode 10: https://stackoverflow.com/questions/52987843/carthage-fails-to-start-when-running-from-xcode-10-build-pre-action/53136006
    unset LLVM_TARGET_TRIPLE_SUFFIX

    echo "Use Xcode 10"

    #xcode 10
    swiftVersion="4.1"
    sed -i '' -e 's/SWIFT_VERSION = 5.0/SWIFT_VERSION = 4.2/g' OHHTTPStubs.xcodeproj/project.pbxproj
else 
    # xcode 11

    echo "Use Xcode 11"

    sed -i '' -e 's/SWIFT_VERSION = 4.2/SWIFT_VERSION = 5.0/g' OHHTTPStubs.xcodeproj/project.pbxproj
fi

rm -rf ../${buildPlatform}/OHHTTPStubs
echo "Clean OHHTTP framework folder complete"

# xcodebuild path
xcodebuild \
 -workspace OHHTTPStubs.xcworkspace \
 -scheme "OHHTTPStubs ${buildPlatformScheme} Framework" \
 -sdk ${buildSdk} \
 -configuration Debug ONLY_ACTIVE_ARCH=NO \
 clean build CONFIGURATION_BUILD_DIR="../${buildPlatform}/OHHTTPStubs"
