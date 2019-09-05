//
//  UIAlertView+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "UIAlertView+DavKit.h"
#import "DKDevice.h"
#import <objc/runtime.h>

typedef enum
{
    DKAlertButtonDefault,
    DKAlertButtonCancel,
    DKAlertButtonDestructive,
} DKAlertButton;

@interface DKAlertUIViewController : UIAlertController

@end

NSString* const DKAlertSheetDisappeared = @"com.davkit.dkalertdisappeared";

@implementation DKAlertUIViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:DKAlertSheetDisappeared object:nil];
}

@end

@interface DKAlertController()
@property(nonatomic,strong) UIAlertController *alert;
@property(nonatomic,strong) NSMutableDictionary *actions;
@property(nonatomic,strong) NSMutableDictionary *clicks;

@property(nonatomic,strong) UIAlertAction *textDoneAction;
@property(strong) BOOL(^textValidator)(NSString*);

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
@property(nonatomic,strong) UIAlertView *view;
@property(nonatomic,strong) UIActionSheet *sheet;
#pragma GCC diagnostic pop

@end

@implementation DKAlertController

static NSMutableArray *legacy = nil;

+ (void)initialize
{
    if (! legacy)
    {
        legacy = [[NSMutableArray alloc] init];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup:nil message:nil];
    }
    return self;
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
    self.clicks = [NSMutableDictionary new];
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
        
        if (style==UIAlertActionStyleCancel)
            if (action!=nil) [self.actions setObject:action forKey:@(UIAlertActionStyleCancel)];
        
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

- (void)addButton:(DKAlertButton)type title:(NSString*)title clicked:(DKEmptyBlock)clicked
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
        
        if (style==UIAlertActionStyleCancel)
            if (clicked!=nil) [self.clicks setObject:clicked forKey:@(UIAlertActionStyleCancel)];
        
        [self.alert addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction *act)
        {
           if (clicked!=NULL)
               clicked();
        }]];
    }
    if (self.view!=nil)
    {
        NSInteger index = [self.view addButtonWithTitle:title];
        if (type==DKAlertButtonCancel)
            self.view.cancelButtonIndex = index;
        if (clicked!=nil) [self.clicks setObject:clicked forKey:@(index)];
    }
    if (self.sheet!=nil)
    {
        NSInteger index = [self.sheet addButtonWithTitle:title];
        if (type==DKAlertButtonCancel)
            self.sheet.cancelButtonIndex = index;
        if (type==DKAlertButtonDestructive)
            self.sheet.destructiveButtonIndex = index;
        if (clicked!=nil) [self.clicks setObject:clicked forKey:@(index)];
    }
}

- (void)addButton:(NSString*)button clicked:(DKEmptyBlock)clicked
{
    [self button:button clicked:clicked];
}

- (void)addButton:(NSString*)btn action:(void (^)(NSString *btn))action
{
    [self button:btn action:action];
}

- (void)button:(NSString*)btn action:(void (^)(NSString *btn))action
{
    [self addButton:DKAlertButtonDefault title:btn action:action];
}

- (void)button:(NSString*)btn clicked:(DKEmptyBlock)clicked
{
    [self addButton:DKAlertButtonDefault title:btn clicked:clicked];
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

- (void)addDestructive:(NSString*)destructive
{
    [self destructive:destructive action:nil];
}
    
- (void)addDestructive:(NSString*)destructive action:(void (^)(NSString *btn))action
{
    [self destructive:destructive action:action];
}
    
- (void)addDestructive:(NSString*)destructive clicked:(DKEmptyBlock)action
{
    [self addButton:DKAlertButtonDestructive title:destructive clicked:action];
}
    
- (void)destructive:(NSString*)destructive action:(void (^)(NSString *btn))action
{
    [self addButton:DKAlertButtonDestructive title:destructive action:action];
}
    
- (void)legacyDismissedWithButtonIndex:(NSInteger)buttonIndex andButtonTitle:(NSString*)btnTitle
{
    id obj = [self.actions objectForKey:@(buttonIndex)];
    if (obj!=nil)
    {
        void (^action)(NSString*)  = obj;
        action(btnTitle);
    }
    id click = [self.clicks objectForKey:@(buttonIndex)];
    if (click!=nil)
    {
        void (^action)(void)  = click;
        action();
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
            {
                self.alert.popoverPresentationController.barButtonItem = (UIBarButtonItem*)container;
            }
            else if (container!=nil && [container isKindOfClass:[UIView class]])
            {
                UIView *v = (UIView*)container;
                self.alert.popoverPresentationController.sourceView = v;
                self.alert.popoverPresentationController.sourceRect = v.bounds;
            }
            else
            {
                self.alert.popoverPresentationController.permittedArrowDirections = 0;
                self.alert.popoverPresentationController.sourceView = parent.view;
                self.alert.popoverPresentationController.sourceRect = parent.view.frame;
            }
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
            if (parent.tabBarController!=nil && [DKDevice isPhone])
            {
                [self.sheet showFromTabBar:parent.tabBarController.tabBar];
                return;
            }
            
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

- (void)addTextField:(void (^)(UITextField *textField))configurator
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [self.alert addTextFieldWithConfigurationHandler:configurator];
    }
    else
    {
        self.view.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *defaultField = [self.view textFieldAtIndex:0];
        if (configurator != nil)
            configurator (defaultField);
    }
}

- (void)addTextValidator:(DKTextFieldValidatorBlock)validator
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        self.textValidator = validator;
        UITextField *defaultField = [self textField:0];
        [self textChanged:defaultField];
        [defaultField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)textChanged:(UITextField*)tf
{
    BOOL enabled = self.textValidator != nil ? self.textValidator(tf.text) : YES;
    self.textDoneAction.enabled = enabled;
}

- (void)addTextDone:(NSString*)button done:(DKTextFieldDoneBlock)done
{
    [self addTextDone:button done:done validator:nil];
}

- (void)addTextDone:(NSString*)button done:(DKTextFieldDoneBlock)done validator:(DKTextFieldValidatorBlock)validator
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        self.textDoneAction = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction*action)
        {
           done(self,[self textField:0].text);
        }];
        [self.alert addAction:self.textDoneAction];
        if (validator!=nil)
            [self addTextValidator:validator];
    }
    else
    {
        // TODO: Figure out how to do this for ios7
    }
}

- (UITextField*)textField:(NSInteger)index
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        return self.alert.textFields[index];
    }
    else
    {
        return [self.view textFieldAtIndex:index];
    }
}

- (void)dismiss
{
    [self dismissAnimated:NO];
}

- (void)dismissAnimated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        UIAlertAction *cancel = nil;
        for (UIAlertAction *action in self.alert.actions)
        {
            if (action.style == UIAlertActionStyleCancel)
            {
                cancel = action;
                break;
            }
        }
        NSString *btnTitle = nil;
        if (cancel!=nil)
            btnTitle = [cancel title];
        
        id obj = [self.actions objectForKey:@(UIAlertActionStyleCancel)];

        [self.alert dismissViewControllerAnimated:animated completion:nil];
        
        if (obj!=nil)
        {
            void (^action)(NSString*)  = obj;
            action(btnTitle);
        }
    }
    else
    {
        if (self.view!=nil)
            [self.view dismissWithClickedButtonIndex:self.view.cancelButtonIndex animated:animated];
        if (self.sheet!=nil)
            [self.sheet dismissWithClickedButtonIndex:self.sheet.cancelButtonIndex animated:animated];
    }
}

@end

@implementation DKAlert

- (void)setup:(NSString*)title message:(NSString*)message
{
    [super setup:title message:message];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
        self.alert = [DKAlertUIViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    else
        [self legacySetup:title message:message];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)legacySetup:(NSString*)title message:(NSString*)message
{
    self.view = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = nil;
    if (buttonIndex!=alertView.cancelButtonIndex)
        btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    [self legacyDismissedWithButtonIndex:buttonIndex andButtonTitle:btnTitle];
}

#pragma clang diagnostic pop
#pragma GCC diagnostic pop

@end

@implementation DKSheet

- (void)setup:(NSString*)title message:(NSString*)message
{
    [super setup:title message:message];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
        self.alert = [DKAlertUIViewController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    else
        [self legacySetup:title message:message];
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

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)legacySetup:(NSString*)title message:(NSString*)message
{
    self.sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = nil;
    if (buttonIndex!=actionSheet.cancelButtonIndex && buttonIndex!=actionSheet.destructiveButtonIndex)
        btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    [self legacyDismissedWithButtonIndex:buttonIndex andButtonTitle:btnTitle];
}

#pragma clang diagnostic pop
#pragma GCC diagnostic pop

@end
