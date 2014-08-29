//
//  UIScrollView+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 25/02/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "UIScrollView+DavKit.h"

@implementation UIScrollView (DavKit)

- (NSString*)scrollDescription
{
    return [NSString stringWithFormat:@"f:%@ t:%@ co:%@ zs:%g",self.frameDescription,NSStringFromCGAffineTransform(self.transform),NSStringFromCGPoint(self.contentOffset),self.zoomScale];
}

- (BOOL)isAtBottom
{
    return [self isAtBottomish:0];
}

- (BOOL)isAtBottomish:(CGFloat)fudgeFactor
{
    if(self.contentOffset.y + fudgeFactor >= (self.contentSize.height - self.frame.size.height))
    {
        return YES;
    }
    return NO;
}

@end
