//
//  UIAlertView+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "UIAlertView+DavKit.h"
#import <objc/runtime.h>

@interface DKAlertInputView (Private)

+ (BOOL)useLegacySupport;
- (UITextField*)safeTextField;
- (void)hideKeyboard;

@end

@implementation UIAlertView (DavKit)

- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
	if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil])
    {
        
		if (cancelButtonTitle)
        {
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = [self numberOfButtons] - 1;
		}
        
		id eachObject;
		va_list argumentList;
		if (otherButtonTitles)
        {
			[self addButtonWithTitle:otherButtonTitles];
			va_start(argumentList, otherButtonTitles);
			while ((eachObject = va_arg(argumentList, id)))
            {
				[self addButtonWithTitle:eachObject];
			}
			va_end(argumentList);
		}
	}
	return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
completionBlock:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))block
{
    UIAlertView *al = [self initWithTitle:title message:message completionBlock:block cancelButtonTitle:nil otherButtonTitles:nil];
    
    if ([otherButtonTitles count]>0)
    {
        for (NSString *btnTitle in otherButtonTitles)
        {
            if ([btnTitle isKindOfClass:[NSString class]])
            {
                [al addButtonWithTitle: btnTitle];
            }
        }
    }
    
    [al setCancelButtonIndex:[al addButtonWithTitle:cancelButtonTitle]];

    return al;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView isKindOfClass:[DKAlertInputView class]])
    {
        void (^block)(DKAlertInputView *inputView,NSString *text) = objc_getAssociatedObject(self, "blockCallback");
        UITextField *textField = ((DKAlertInputView *)alertView).safeTextField;
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
        {
            NSString *text = [textField text];
            block(((DKAlertInputView*)self),text);
        }
        
        [((DKAlertInputView *)alertView) hideKeyboard];
    }
    else
    {
        void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
        block(buttonIndex, self);
    }
}

@end

@implementation DKAlertInputView
//@synthesize textField;
@synthesize isSecure;

- (void)prepare:(UITextField*)tf current:(NSString*)current placeHolder:(NSString*)placeHolder
{
    [tf setText:current];
    [tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [tf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [tf setKeyboardType:UIKeyboardTypeEmailAddress];
    [tf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [tf setFont:[UIFont systemFontOfSize:14]];
    
    [tf setPlaceholder:placeHolder];
    [tf setKeyboardAppearance:UIKeyboardAppearanceAlert];
    tf.secureTextEntry = isSecure;
}

+ (BOOL)useLegacySupport
{
    return [[[UIDevice currentDevice] systemVersion] floatValue]<5.0;
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        placeHolder:(NSString*)placeHolder
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    return [self initWithTitle:title current:current placeHolder:placeHolder secure:NO block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        placeHolder:(NSString*)placeHolder
             secure:(BOOL)secure
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    return [self initWithTitle:title current:current placeHolder:placeHolder secure:secure ok:@"OK" cancel:@"Cancel" block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        placeHolder:(NSString*)placeHolder
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    return [self initWithTitle:title current:current placeHolder:placeHolder secure:NO ok:ok cancel:cancel block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        placeHolder:(NSString*)placeHolder
             secure:(BOOL)secure
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    objc_setAssociatedObject(self,"blockCallback",[block copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    isSecure = secure;
    
    BOOL useLegacySupport = [DKAlertInputView useLegacySupport];
    
    self.dkDelegate = [[DKAlertInputViewUIAlertViewDelegate alloc] init];
    self.okTitle = ok;
    
    if (self = [super initWithTitle:title message:useLegacySupport ? @"\n\n" : @"" delegate:self.dkDelegate cancelButtonTitle:cancel otherButtonTitles:ok, nil])
    {
        if (useLegacySupport)
        {
            textField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 55, 260.0, 30.0)];
            [textField setBorderStyle:UITextBorderStyleRoundedRect];
            [self prepare:textField current:current placeHolder:placeHolder];
            [self addSubview:textField];
        }
        else
        {
            self.alertViewStyle = isSecure ? UIAlertViewStyleSecureTextInput : UIAlertViewStylePlainTextInput;
            UITextField *defaultField = [self textFieldAtIndex:0];
            [self prepare:defaultField current:current placeHolder:placeHolder];
        }
    }
    
    return self;
}

- (void)setAutocapitalizationType:(UITextAutocapitalizationType)type
{
    self.safeTextField.autocapitalizationType = type;
}

- (void)setAutocorrectionType:(UITextAutocorrectionType)type
{
    self.safeTextField.autocorrectionType = type;
}

- (void)setKeyboardType:(UIKeyboardType)type
{
    self.safeTextField.keyboardType = type;
}

- (UITextField*)safeTextField
{
    UITextField*tf = nil;
    if ([DKAlertInputView useLegacySupport])
    {
        tf = textField;
    }
    else
    {
        tf = [self textFieldAtIndex:0];
    }
    return tf;
}

- (NSString*)textFieldText
{
    return [self.safeTextField text];
}

- (void)dealloc
{

}

- (void)finishedWithText:(NSString*)text
{
    void (^block)(DKAlertInputView *inputView,NSString *text) = objc_getAssociatedObject(self, "blockCallback");
    block(((DKAlertInputView*)self),text);
}

- (void)cancelled
{
    
}

@end

@implementation DKAlertInputViewUIAlertViewDelegate

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    [((DKAlertInputView*)alertView).safeTextField becomeFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DKAlertInputView *input = ((DKAlertInputView*)alertView);
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:input.okTitle])
        [input finishedWithText:input.safeTextField.text];
    else
        [input cancelled];
}

@end

