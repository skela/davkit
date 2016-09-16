//
//  UIAlertViewLegacy.m
//  Constructor
//
//  Created by Aleksander Slater on 15/09/2016.
//  Copyright © 2016 IntroLabs. All rights reserved.
//

#import "UIAlertViewLegacy.h"
#import <objc/runtime.h>

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
    void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
    block(buttonIndex, self);
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
