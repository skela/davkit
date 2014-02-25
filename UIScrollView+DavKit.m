//
//  UIScrollView+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 25/02/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import "UIScrollView+DavKit.h"

@implementation UIScrollView (DavKit)

- (NSString*)scrollDescription
{
    return [NSString stringWithFormat:@"f:%@ t:%@ co:%@ zs:%g",self.frameDescription,NSStringFromCGAffineTransform(self.transform),NSStringFromCGPoint(self.contentOffset),self.zoomScale];
}

@end
