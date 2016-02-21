/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingCampingTripWrapper.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingCampingTripWrapper (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLGocampingCampingTrip;
@class GTLGocampingUserAccount;

// ----------------------------------------------------------------------------
//
//   GTLGocampingCampingTripWrapper
//

@interface GTLGocampingCampingTripWrapper : GTLObject
@property (nonatomic, retain) GTLGocampingCampingTrip *campingTrip;
@property (nonatomic, retain) NSArray *campingTrips;  // of GTLGocampingCampingTrip
@property (nonatomic, retain) GTLGocampingUserAccount *userAccount;
@end
