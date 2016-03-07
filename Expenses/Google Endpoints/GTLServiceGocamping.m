/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLServiceGocamping.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLServiceGocamping (0 custom class methods, 0 custom properties)

#import "GTLGocamping.h"

@implementation GTLServiceGocamping

#if DEBUG
// Method compiled in debug builds just to check that all the needed support
// classes are present at link time.
+ (NSArray *)checkClasses {
  NSArray *classes = @[
    [GTLQueryGocamping class],
    [GTLGocampingCampingTrip class],
    [GTLGocampingCampingTripCollection class],
    [GTLGocampingCampingTripValidationResult class],
    [GTLGocampingCampingTripWrapper class],
    [GTLGocampingExpense class],
    [GTLGocampingExpenseCollection class],
    [GTLGocampingFamiliesWrapper class],
    [GTLGocampingFamily class],
    [GTLGocampingFamilyRSVPWrapper class],
    [GTLGocampingGeoPt class],
    [GTLGocampingMember class],
    [GTLGocampingMemberCollection class],
    [GTLGocampingUserAccount class]
  ];
  return classes;
}
#endif  // DEBUG

- (instancetype)init {
  self = [super init];
  if (self) {
    // Version from discovery.
    self.apiVersion = @"v1";

    // From discovery.  Where to send JSON-RPC.
    // Turn off prettyPrint for this service to save bandwidth (especially on
    // mobile). The fetcher logging will pretty print.
    self.rpcURL = [NSURL URLWithString:@"https://gocampingapis.appspot.com/_ah/api/rpc?prettyPrint=false"];
  }
  return self;
}

@end