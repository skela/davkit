//
//  UIAlertView+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

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

@interface DKAlertController : NSObject

- (instancetype)initWithTitle:(NSString*)title;
- (instancetype)initWithTitle:(NSString*)title andMessage:(NSString*)msg;

- (void)addButton:(NSString*)btn action:(void (^)(NSString *btn))action;
- (void)addCancel:(NSString*)cancel;
- (void)addCancel:(NSString*)cancel action:(void (^)(NSString *btn))action;

- (void)button:(NSString*)btn action:(void (^)(NSString *btn))action;
- (void)cancel:(NSString*)cancel action:(void (^)(NSString *btn))action;

- (void)show:(UIViewController*)parent;
- (void)show:(UIViewController*)parent container:(id)container;
- (void)show:(UIViewController*)parent container:(id)container animated:(BOOL)animated;

- (void)addTextField:(void (^)(UITextField *textField))configurator;
- (void)addTextDone:(NSString*)button done:(void (^)(id sender,NSString *text))done;
- (UITextField*)textField:(NSInteger)index;

- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

@end

@interface DKAlert : DKAlertController <UIAlertViewDelegate>

@end

@interface DKSheet : DKAlertController <UIActionSheetDelegate>

- (void)addDestructive:(NSString*)destructive;
- (void)addDestructive:(NSString*)destructive action:(void (^)(NSString *btn))action;
- (void)addButtons:(NSArray*)btns action:(void (^)(NSString *btn))action;

- (void)destructive:(NSString*)destructive action:(void (^)(NSString *btn))action;
- (void)buttons:(NSArray*)btns action:(void (^)(NSString *btn))action;

@end
