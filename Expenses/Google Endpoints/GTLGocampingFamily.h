/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingFamily.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingFamily (0 custom class methods, 9 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLGocampingFamily
//

@interface GTLGocampingFamily : GTLObject
@property (nonatomic, copy) NSString *email;
@property (nonatomic, retain) NSArray *expenseIds;  // of NSNumber (longLongValue)
@property (nonatomic, copy) NSString *fullName;

// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, retain) NSNumber *identifier;  // longLongValue

@property (nonatomic, retain) NSArray *memberIds;  // of NSNumber (longLongValue)
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, retain) NSNumber *totalOwedExpenseAmount;  // doubleValue
@property (nonatomic, retain) NSNumber *totalSpentExpenseAmount;  // doubleValue
@property (nonatomic, copy) NSString *tripRSVPStatus;
@end
