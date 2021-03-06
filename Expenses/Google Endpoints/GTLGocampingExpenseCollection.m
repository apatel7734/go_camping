/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingExpenseCollection.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingExpenseCollection (0 custom class methods, 1 custom properties)

#import "GTLGocampingExpenseCollection.h"

#import "GTLGocampingExpense.h"

// ----------------------------------------------------------------------------
//
//   GTLGocampingExpenseCollection
//

@implementation GTLGocampingExpenseCollection
@dynamic items;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"items" : [GTLGocampingExpense class]
  };
  return map;
}

@end
