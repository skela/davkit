//
//  UIView_F.h
//  DavKit
//
//  Created by Aleksander Slater on 13/06/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (F)
- (CGFloat)dy;
- (CGFloat)dx;
- (CGFloat)y;
- (CGFloat)x;
- (CGFloat)w;
- (CGFloat)h;
- (CGPoint)o;
- (CGSize)s;
- (CGFloat)cy;
- (CGFloat)cx;

- (void)setW:(CGFloat)w;
- (void)setH:(CGFloat)h;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setO:(CGPoint)o;
- (void)setS:(CGSize)s;
- (void)setCy:(CGFloat)cy;
- (void)setCx:(CGFloat)cx;

@end
