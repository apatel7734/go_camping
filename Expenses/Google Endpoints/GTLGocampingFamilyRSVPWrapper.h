/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingFamilyRSVPWrapper.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingFamilyRSVPWrapper (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLGocampingFamilyRSVPWrapper
//

@interface GTLGocampingFamilyRSVPWrapper : GTLObject
@property (nonatomic, retain) NSNumber *campingTripId;  // longLongValue
@property (nonatomic, retain) NSNumber *familyId;  // longLongValue
@property (nonatomic, copy) NSString *familyRSVPedResponse;
@property (nonatomic, retain) NSNumber *totalMembersComing;  // intValue
@end
