/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingMemberCollection.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingMemberCollection (0 custom class methods, 1 custom properties)

#import "GTLGocampingMemberCollection.h"

#import "GTLGocampingMember.h"

// ----------------------------------------------------------------------------
//
//   GTLGocampingMemberCollection
//

@implementation GTLGocampingMemberCollection
@dynamic items;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"items" : [GTLGocampingMember class]
  };
  return map;
}

@end