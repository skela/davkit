//
//  UIScrollView+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 25/02/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (DavKit)

- (NSString*)scrollDescription;
- (BOOL)isAtBottom;
- (BOOL)isAtBottomish:(CGFloat)fudgeFactor;

@end
