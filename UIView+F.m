//
//  UIView_F.h
//  DavKit
//
//  Created by Aleksander Slater on 13/06/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+F.h"
#import "DKF.h"

@implementation UIView (F)

- (CGFloat)dy
{
    return [F dy:self];
}

- (CGFloat)dx
{
    return [F dx:self];
}

- (CGFloat)y
{
    return [F y:self];
}

- (CGFloat)x
{
    return [F x:self];
}

- (CGFloat)w
{
    return [F w:self];
}

- (CGFloat)h
{
    return [F h:self];
}

- (CGPoint)o
{
    return [F o:self];
}

- (CGSize)s
{
    return [F s:self];
}

- (void)setW:(CGFloat)w
{
    [F v:self w:w];
}

- (void)setH:(CGFloat)h
{
    [F v:self h:h];
}

- (void)setY:(CGFloat)y
{
    [F v:self y:y];
}

- (void)setX:(CGFloat)x
{
    [F v:self x:x];
}

- (void)setO:(CGPoint)o
{
    [F v:self o:o];
}

- (void)setS:(CGSize)s
{
    [F v:self s:s];
}

@end

