// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import "AppCenter.h"
#import "MSDataError.h"
#import "MSDataErrors.h"
#import "MSTestFrameworks.h"

@interface MSDataErrorTests : XCTestCase

@end

@implementation MSDataErrorTests

- (void)testInitWithErrorCallsParsingMethod {

  // If
  NSInteger expectedErrorCode = MSHTTPCodesNo500InternalServerError;
  NSDictionary *userInfo = @{@"MSHttpCodeKey" : @(expectedErrorCode)};
  NSError *error = [NSError errorWithDomain:kMSACErrorDomain code:0 userInfo:userInfo];
  id dataErrorMock = OCMClassMock([MSDataError class]);
  NSInteger errorCode = 1;
  NSString *errorMessage = @"A serious error message!";

  // When
  MSDataError *dataError = [[MSDataError alloc] initWithInnerError:error code:errorCode message:errorMessage];

  // Then
  XCTAssertEqual(errorCode, dataError.code);
  NSError *innerError = [dataError innerError];
  XCTAssertNotNil(innerError);
  XCTAssertTrue([innerError.userInfo[@"MSHttpCodeKey"] integerValue] == expectedErrorCode);
  XCTAssertEqualObjects(error, dataError.userInfo[NSUnderlyingErrorKey]);
  [dataErrorMock stopMocking];
}

- (void)testErrorCodeFromErrorParsesCodeFromUserInfo {

  // If
  NSInteger expectedErrorCode = MSHTTPCodesNo500InternalServerError;
  NSDictionary *userInfo = @{@"MSHttpCodeKey" : @(expectedErrorCode)};

  // When
  MSDataError *dataError = [[MSDataError alloc] initWithUserInfo:userInfo code:0];

  // Then
  XCTAssertTrue([dataError.userInfo[@"MSHttpCodeKey"] integerValue] == expectedErrorCode);
}

@end
