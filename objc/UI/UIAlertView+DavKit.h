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

// Note: This doesn't work on iOS7->
@class DKAlertSliderUIAlertViewDelegate;
@interface DKAlertSliderView : UIAlertView <UIAlertViewDelegate>
@property(nonatomic,strong) DKAlertSliderUIAlertViewDelegate *dkDelegate;
@property(nonatomic,strong) UISlider *slider;
@property(nonatomic,strong) NSString *okTitle;

- (id)initWithTitle:(NSString *)title
            current:(NSNumber*)value
              block:(void (^)(DKAlertSliderView *inputView,NSNumber *value))block;

- (id)initWithTitle:(NSString *)title
            current:(NSNumber*)value
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertSliderView *inputView,NSNumber *value))block;

@end

@interface DKAlertSliderUIAlertViewDelegate : NSObject <UIAlertViewDelegate>
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

@end

@interface DKAlert : DKAlertController <UIAlertViewDelegate>

@end

@interface DKSheet : DKAlertController <UIActionSheetDelegate>

- (void)addDestructive:(NSString*)destructive;
- (void)addButtons:(NSArray*)btns action:(void (^)(NSString *btn))action;

- (void)destructive:(NSString*)destructive action:(void (^)(NSString *btn))action;
- (void)buttons:(NSArray*)btns action:(void (^)(NSString *btn))action;

@end
