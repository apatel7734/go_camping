/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingCampingTripWrapper.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingCampingTripWrapper (0 custom class methods, 3 custom properties)

#import "GTLGocampingCampingTripWrapper.h"

#import "GTLGocampingCampingTrip.h"
#import "GTLGocampingUserAccount.h"

// ----------------------------------------------------------------------------
//
//   GTLGocampingCampingTripWrapper
//

@implementation GTLGocampingCampingTripWrapper
@dynamic campingTrip, campingTrips, userAccount;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"campingTrips" : [GTLGocampingCampingTrip class]
  };
  return map;
}

@end
