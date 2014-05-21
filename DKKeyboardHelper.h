//
//  DKKeyboardHelper.h
//  blit
//
//  Created by Aleksander Slater on 10/05/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKKeyboardHelper : NSObject
@property(nonatomic,strong) NSMutableArray *adjustableViews;
@property(nonatomic,strong) NSNotification *lastNotification;

- (void)addTextView:(UITextView*)textView;
- (void)removeTextView:(UITextView*)textView;
- (void)addScrollView:(UIScrollView*)scrollView;
- (void)removeScrollView:(UIScrollView*)scrollView;

@end
