//
//  NSArray+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 24/10/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DavKit)

- (NSArray*)subarrayWithCount:(NSUInteger)count;
- (NSArray*)subarrayFromIndex:(NSUInteger)index;
- (id)randomObject;

@end
