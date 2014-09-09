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

@end

@class DKAlertInputViewUIAlertViewDelegate;
@interface DKAlertInputView : UIAlertView <UIAlertViewDelegate>
{
	UITextField *textField;
    BOOL isSecure;
}
@property(nonatomic,readwrite) BOOL isSecure;
@property(nonatomic,strong) DKAlertInputViewUIAlertViewDelegate *dkDelegate;
@property(nonatomic,strong) NSString *okTitle;

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block;

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
             secure:(BOOL)secure
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block;

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block;

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
             secure:(BOOL)secure
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block;

- (void)setAutocapitalizationType:(UITextAutocapitalizationType)type;
- (void)setAutocorrectionType:(UITextAutocorrectionType)type;
- (void)setKeyboardType:(UIKeyboardType)type;

- (NSString*)textFieldText;

@end

@interface DKAlertInputViewUIAlertViewDelegate : NSObject <UIAlertViewDelegate>

@end