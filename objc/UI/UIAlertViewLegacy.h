//
//  UIAlertViewLegacy.h
//  Constructor
//
//  Created by Aleksander Slater on 15/09/2016.
//  Copyright © 2016 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (DavKit) <UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
    completionBlock:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))block;

- (void)addButton:(NSString*)title;
- (void)addCancel:(NSString*)title;
- (void)addButtons:(NSArray*)btns;

@end
