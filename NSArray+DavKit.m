//
//  NSArray+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 24/10/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "NSArray+DavKit.h"

@implementation NSArray (DavKit)

- (NSArray*)subarrayWithCount:(NSUInteger)count
{
    if (self.count<=count)
        return self;
    NSRange r; r.location=0; r.length=count;
    return [self subarrayWithRange:r];
}

- (NSArray*)subarrayFromIndex:(NSUInteger)index
{
    if (index < self.count)
    {
        NSRange r; r.location=index; r.length=self.count-index;
        return [self subarrayWithRange:r];
    }
    return nil;
}

@end
