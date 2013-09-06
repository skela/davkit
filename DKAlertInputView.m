//
//  DKAlertView.m
//  DAVKIT
//
//  Created by Aleksander Slater on 05/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "DKAlertInputView.h"
#import <objc/runtime.h>

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

- (id)initWithTitle:(NSString *)title current:(NSString*)current placeHolder:(NSString*)placeHolder block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    objc_setAssociatedObject(self, "blockCallback",[block copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    BOOL useLegacySupport = [[[UIDevice currentDevice] systemVersion] floatValue]<5.0;
    
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

- (void)show
{
    [textField becomeFirstResponder];
    [super show];
}

- (void)dealloc
{
    [textField release];
    [super dealloc];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    void (^block)(DKAlertInputView *inputView,NSString *text) = objc_getAssociatedObject(self, "blockCallback");
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
    {
        BOOL useLegacySupport = [[[UIDevice currentDevice] systemVersion] floatValue]<5.0;
        NSString *text = [NSString stringWithFormat:@"%@",textField.text];
        if (!useLegacySupport)
        {
            text = [NSString stringWithFormat:@"%@",[self textFieldAtIndex:0].text];
        }
        
        block(self,text);
    }
}

@end