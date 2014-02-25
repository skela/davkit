//
//  UIView+DavKit.m
//  Constructor
//
//  Created by Aleksander Slater on 25/02/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import "UIView+DavKit.h"

@implementation UIView (DavKit)

- (NSString*)frameDescription
{
    return [NSString stringWithFormat:@"[%g,%g,%g,%g]",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height];
}

- (NSString*)viewDescription
{
    return [NSString stringWithFormat:@"f:%@ t:%@",self.frameDescription,NSStringFromCGAffineTransform(self.transform)];
}

@end
