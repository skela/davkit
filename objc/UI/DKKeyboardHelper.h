//
//  DKKeyboardHelper.h
//  blit
//
//  Created by Aleksander Slater on 10/05/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DKKeyboardHelper : NSObject
@property(nonatomic,strong) NSMutableArray *adjustableViews;
@property(nonatomic,strong) NSNotification *lastNotification;
@property(nonatomic,readwrite) CGFloat topBarHeight;

- (id)initWithView:(UIScrollView*)scrollView;

- (void)addView:(UIScrollView*)scrollView;
- (void)removeView:(UIScrollView*)scrollView;

@end
