//
//  UIAlertView+DavKit.m
//  DropBeacon
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "UIAlertView+DavKit.h"
#import <objc/runtime.h>

@interface DKAlertInputView (Private)

+ (BOOL)useLegacySupport;

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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView isKindOfClass:[DKAlertInputView class]])
    {
        void (^block)(DKAlertInputView *inputView,NSString *text) = objc_getAssociatedObject(self, "blockCallback");
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
        {
            BOOL useLegacySupport = [DKAlertInputView useLegacySupport];
            NSString *text = [NSString stringWithFormat:@"%@",[((DKAlertInputView*)alertView) textFieldText]];
            if (!useLegacySupport)
            {
                text = [NSString stringWithFormat:@"%@",[self textFieldAtIndex:0].text];
            }
            
            block(((DKAlertInputView*)self),text);
        }
    }
    else
    {
        void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
        block(buttonIndex, self);
    }
}

@end

@implementation DKAlertInputView
@synthesize textField;

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
}

+ (BOOL)useLegacySupport
{
    return [[[UIDevice currentDevice] systemVersion] floatValue]<5.0;
}

- (id)initWithTitle:(NSString *)title current:(NSString*)current placeHolder:(NSString*)placeHolder block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    objc_setAssociatedObject(self, "blockCallback",[block copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    BOOL useLegacySupport = [DKAlertInputView useLegacySupport];
    
    if (self = [super initWithTitle:title message:useLegacySupport ? @"\n\n" : @"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil])
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
            self.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *defaultField = [self textFieldAtIndex:0];
            [self prepare:defaultField current:current placeHolder:placeHolder];
        }
    }
    return self;
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

- (void)setSecureTextEntry:(BOOL)secure
{
    [self.safeTextField setSecureTextEntry:secure];
}

- (NSString*)textFieldText
{
    return [self.safeTextField text];
}

- (void)show
{
    [self.safeTextField becomeFirstResponder];
    [super show];
}

- (void)dealloc
{
    self.textField = nil;
}

@end

