//
//  DKKeyboardHelper.m
//  blit
//
//  Created by Aleksander Slater on 10/05/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKKeyboardHelper.h"

@implementation DKKeyboardHelper

- (id)init
{
    self = [super init];
    if (self)
    {
        self.adjustableViews = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidHide:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [self.adjustableViews removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addTextView:(UITextView*)textView
{
    [self addScrollView:textView];
}

- (void)removeTextView:(UITextView*)textView
{
    [self removeScrollView:textView];
}

- (void)addScrollView:(UIScrollView*)scrollView
{
    [self.adjustableViews addObject:scrollView];
}

- (void)removeScrollView:(UIScrollView*)scrollView
{
    [self.adjustableViews removeObject:scrollView];
}

- (void)keyboardWillShow:(NSNotification*)n
{
    self.lastNotification = n;
    self.lastNotification = nil;
}

- (void)keyboardDidShow:(NSNotification*)n
{
    self.lastNotification = n;
    for (UIView *v in self.adjustableViews)
        [self adjustView:v];
    self.lastNotification = nil;
}

- (void)keyboardWillHide:(NSNotification*)n
{
    self.lastNotification = n;
    self.lastNotification = n;
    for (UIView *v in self.adjustableViews)
        [self deAdjustView:v];
    self.lastNotification = nil;
}

- (void)keyboardDidHide:(NSNotification*)n
{
    self.lastNotification = n;
    self.lastNotification = nil;
}

- (void)adjustView:(UIView*)view
{
    if ([view isKindOfClass:[UIScrollView class]])
        [self adjustScrollView:(UIScrollView*)view];
}

- (void)deAdjustView:(UIView*)view
{
    if ([view isKindOfClass:[UIScrollView class]])
        [self deAdjustScrollView:(UIScrollView*)view];
}

// Best to call this from KeyboardDidShow
- (void)adjustScrollView:(UIScrollView *)scrollView
{
    if (self.lastNotification != nil)
    {
        CGRect keyboardRect;
        [[[self.lastNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardRect];
        CGRect keyFrame = [[UIApplication sharedApplication].keyWindow.rootViewController.view convertRect:keyboardRect fromView:nil];
        CGSize kbSize = keyFrame.size;

        if (scrollView != nil)
        {
            UIEdgeInsets contentInsets = UIEdgeInsetsMake (0.0f, 0.0f, kbSize.height, 0.0f);
            scrollView.ContentInset = contentInsets;
            scrollView.ScrollIndicatorInsets = contentInsets;
        }
    }
}

// Best to call this from KeyboardWillHide
- (void)deAdjustScrollView:(UIScrollView*)scrollView
{
    if (scrollView != nil)
    {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        scrollView.ContentInset = contentInsets;
        scrollView.ScrollIndicatorInsets = contentInsets;
    }
}

@end
