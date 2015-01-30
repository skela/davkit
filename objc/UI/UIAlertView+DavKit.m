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

- (void)addButton:(NSString*)title
{
    if (title) [self addButtonWithTitle:title];
}

- (void)addCancel:(NSString*)title
{
    if (title) [self setCancelButtonIndex:[self addButtonWithTitle:title]];
}

- (void)addButtons:(NSArray*)btns
{
    for (NSString *btnTitle in btns)
    {
        [self addButton:btnTitle];
    }
}

@end

@implementation DKAlertInputView
@synthesize isSecure;

- (void)prepare:(UITextField*)tf current:(NSString*)current hint:(NSString*)placeHolder
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
        hint:(NSString*)placeHolder
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    return [self initWithTitle:title current:current hint:placeHolder secure:NO block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
             secure:(BOOL)secure
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    return [self initWithTitle:title current:current hint:placeHolder secure:secure ok:@"OK" cancel:@"Cancel" block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertInputView *inputView,NSString *text))block
{
    return [self initWithTitle:title current:current hint:placeHolder secure:NO ok:ok cancel:cancel block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSString*)current
        hint:(NSString*)placeHolder
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
            [self prepare:textField current:current hint:placeHolder];
            [self addSubview:textField];
        }
        else
        {
            self.alertViewStyle = isSecure ? UIAlertViewStyleSecureTextInput : UIAlertViewStylePlainTextInput;
            UITextField *defaultField = [self textFieldAtIndex:0];
            [self prepare:defaultField current:current hint:placeHolder];
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


@implementation DKAlertSliderView
@synthesize slider;

- (id)initWithTitle:(NSString *)title
            current:(NSNumber*)value
              block:(void (^)(DKAlertSliderView *inputView,NSNumber *value))block
{
    return [self initWithTitle:title current:value ok:@"OK" cancel:@"Cancel" block:block];
}

- (id)initWithTitle:(NSString *)title
            current:(NSNumber*)value
                 ok:(NSString*)ok
             cancel:(NSString*)cancel
              block:(void (^)(DKAlertSliderView *inputView,NSNumber *value))block
{
    objc_setAssociatedObject(self,"blockCallback",[block copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.dkDelegate = [[DKAlertSliderUIAlertViewDelegate alloc] init];
    self.okTitle = ok;
    
    if (self = [super initWithTitle:title message:@"\n\n" delegate:self.dkDelegate cancelButtonTitle:cancel otherButtonTitles:ok, nil])
    {
        self.slider = [[UISlider alloc] initWithFrame:CGRectMake(12.0, 55, 260.0, 30.0)];
        slider.value = [value floatValue];
        [self addSubview:slider];
    }
    
    return self;
}

- (void)finished
{
    void (^block)(DKAlertSliderView *inputView,NSNumber *value) = objc_getAssociatedObject(self, "blockCallback");
    block(((DKAlertSliderView*)self), @([slider value]));
}

- (void)cancelled
{
    
}

@end

@implementation DKAlertSliderUIAlertViewDelegate

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DKAlertSliderView *input = ((DKAlertSliderView*)alertView);
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:input.okTitle])
        [input finished];
    else
        [input cancelled];
}

@end

typedef enum
{
    DKAlertButtonDefault,
    DKAlertButtonCancel,
    DKAlertButtonDestructive,
} DKAlertButton;

@interface DKAlertController()
@property(nonatomic,strong) UIAlertController *alert;
@property(nonatomic,strong) UIAlertView *view;
@property(nonatomic,strong) UIActionSheet *sheet;
@property(nonatomic,strong) NSMutableDictionary *actions;
@end

@implementation DKAlertController

static NSMutableArray *legacy = nil;

+ (void)initialize
{
    if (! legacy)
        legacy = [[NSMutableArray alloc] init];
}

- (instancetype)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self)
    {
        [self setup:title message:nil];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title andMessage:(NSString*)msg
{
    self = [super init];
    if (self)
    {
        [self setup:title message:msg];
    }
    return self;
}

- (void)setup:(NSString*)title message:(NSString*)message
{
    self.actions = [NSMutableDictionary new];
}

- (void)addButton:(DKAlertButton)type title:(NSString*)title action:(void (^)(NSString *btn))action
{
    if (self.alert!=nil)
    {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        switch (type)
        {
            case DKAlertButtonCancel: style = UIAlertActionStyleCancel; break;
            case DKAlertButtonDestructive: style = UIAlertActionStyleDestructive; break;
            case DKAlertButtonDefault: style = UIAlertActionStyleDefault; break;
        }
        if (style==UIAlertActionStyleDestructive && self.view!=nil)
            style = UIAlertActionStyleDefault;
        
        [self.alert addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction *act)
        {
           if (action!=NULL)
               action(act.title);
        }]];
    }
    if (self.view!=nil)
    {
        NSInteger index = [self.view addButtonWithTitle:title];
        if (type==DKAlertButtonCancel)
            self.view.cancelButtonIndex = index;
        if (action!=nil) [self.actions setObject:action forKey:@(index)];
    }
    if (self.sheet!=nil)
    {
        NSInteger index = [self.sheet addButtonWithTitle:title];
        if (type==DKAlertButtonCancel)
            self.sheet.cancelButtonIndex = index;
        if (type==DKAlertButtonDestructive)
            self.sheet.destructiveButtonIndex = index;
        if (action!=nil) [self.actions setObject:action forKey:@(index)];
    }
}

- (void)addButton:(NSString*)btn action:(void (^)(NSString *btn))action
{
    [self button:btn action:action];
}

- (void)button:(NSString*)btn action:(void (^)(NSString *btn))action
{
    [self addButton:DKAlertButtonDefault title:btn action:action];
}

- (void)addCancel:(NSString*)cancel
{
    [self cancel:cancel action:nil];
}

- (void)addCancel:(NSString*)cancel action:(void (^)(NSString *btn))action
{
    [self cancel:cancel action:action];
}

- (void)cancel:(NSString*)cancel action:(void (^)(NSString *btn))action
{
    [self addButton:DKAlertButtonCancel title:cancel action:action];
}

- (void)legacyDismissedWithButtonIndex:(NSInteger)buttonIndex andButtonTitle:(NSString*)btnTitle
{
    id obj = [self.actions objectForKey:@(buttonIndex)];
    if (obj!=nil)
    {
        void (^action)()  = obj;
        action(btnTitle);
    }
    [legacy removeObject:self];
}

- (void)show:(UIViewController*)parent container:(id)container animated:(BOOL)animated
{
    if (self.alert!=nil)
    {
        if (self.alert.popoverPresentationController!=nil)
        {
            if (container!=nil && [container isKindOfClass:[UIBarButtonItem class]])
                self.alert.popoverPresentationController.barButtonItem = (UIBarButtonItem*)container;
            else
                self.alert.popoverPresentationController.sourceView = parent.view;
        }        
        [parent presentViewController:self.alert animated:YES completion:nil];
    }
    if (self.view!=nil)
    {
        [legacy addObject:self];
        [self.view show];
    }
    if (self.sheet!=nil)
    {
        [legacy addObject:self];
        
        if (container!=nil)
        {
            if ([container isKindOfClass:[UIBarButtonItem class]])
                [self.sheet showFromBarButtonItem:container animated:YES];
            else if ([container isKindOfClass:[UITabBar class]])
                [self.sheet showFromTabBar:container];
            else if ([container isKindOfClass:[UIToolbar class]])
                [self.sheet showFromToolbar:container];
            else if ([container isKindOfClass:[UIView class]])
                [self.sheet showInView:container];
            else
                [self.sheet showInView:parent.view];
        }
        else
        {
            if (parent.tabBarController.tabBar!=nil)
                [self.sheet showFromTabBar:parent.tabBarController.tabBar];
            else
                [self.sheet showInView:parent.view];
        }
    }
}

- (void)show:(UIViewController*)parent container:(id)container
{
    [self show:parent container:container animated:YES];
}

- (void)show:(UIViewController*)parent
{
    [self show:parent container:nil];
}

@end

@implementation DKAlert

- (void)setup:(NSString*)title message:(NSString*)message
{
    [super setup:title message:message];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
        self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    else
        self.view = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = nil;
    if (buttonIndex!=alertView.cancelButtonIndex)
        btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    [self legacyDismissedWithButtonIndex:buttonIndex andButtonTitle:btnTitle];
}

@end

@implementation DKSheet

- (void)setup:(NSString*)title message:(NSString*)message
{
    [super setup:title message:message];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
        self.alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    else
        self.sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
}

- (void)addDestructive:(NSString*)destructive
{
    [self destructive:destructive action:nil];
}

- (void)addDestructive:(NSString*)destructive action:(void (^)(NSString *btn))action
{
    [self destructive:destructive action:action];
}

- (void)destructive:(NSString*)destructive action:(void (^)(NSString *btn))action
{
    [self addButton:DKAlertButtonDestructive title:destructive action:action];
}

- (void)addButtons:(NSArray*)btns action:(void (^)(NSString *btn))action
{
    [self buttons:btns action:action];
}

- (void)buttons:(NSArray*)btns action:(void (^)(NSString *btn))action
{
    for (NSString *btn in btns)
        [self addButton:DKAlertButtonDefault title:btn action:action];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = nil;
    if (buttonIndex!=actionSheet.cancelButtonIndex && buttonIndex!=actionSheet.destructiveButtonIndex)
        btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    [self legacyDismissedWithButtonIndex:buttonIndex andButtonTitle:btnTitle];
}

@end
