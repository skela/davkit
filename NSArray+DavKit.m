//
//  NSArray+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 24/10/2013.
//  Copyright (c) 2013 IntroLabs. All rights reserved.
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

@end
