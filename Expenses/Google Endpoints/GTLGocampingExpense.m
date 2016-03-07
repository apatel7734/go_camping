/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingExpense.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingExpense (0 custom class methods, 5 custom properties)

#import "GTLGocampingExpense.h"

// ----------------------------------------------------------------------------
//
//   GTLGocampingExpense
//

@implementation GTLGocampingExpense
@dynamic descriptionProperty, familyId, identifier, itemCost, itemName;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map = @{
    @"descriptionProperty" : @"description",
    @"identifier" : @"id"
  };
  return map;
}

@end