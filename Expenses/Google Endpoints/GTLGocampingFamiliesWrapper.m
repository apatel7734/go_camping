/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLGocampingFamiliesWrapper.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   gocamping/v1
// Description:
//   This is an API
// Classes:
//   GTLGocampingFamiliesWrapper (0 custom class methods, 1 custom properties)

#import "GTLGocampingFamiliesWrapper.h"

#import "GTLGocampingFamily.h"

// ----------------------------------------------------------------------------
//
//   GTLGocampingFamiliesWrapper
//

@implementation GTLGocampingFamiliesWrapper
@dynamic families;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"families" : [GTLGocampingFamily class]
  };
  return map;
}

@end