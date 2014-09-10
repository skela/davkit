//
//  UIActionSheet+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "UIActionSheet+DavKit.h"
#import <objc/runtime.h>

@implementation UIActionSheet (DavKit) 

- (id)initWithTitle:(NSString *)title completionBlock:(void (^)(NSUInteger buttonIndex, UIActionSheet *actionSheet))block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	if (self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil])
    {
        
		if (destructiveButtonTitle)
        {
			self.destructiveButtonIndex = [self addButtonWithTitle:destructiveButtonTitle];
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
        
		if (cancelButtonTitle)
        {
			self.cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
		}
	}
	return self;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completionBlock:(void (^)(NSUInteger buttonIndex, UIActionSheet *actionSheet))block
{
	objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	if (self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil])
    {
		if (destructiveButtonTitle)
        {
			self.destructiveButtonIndex = [self addButtonWithTitle:destructiveButtonTitle];
		}
        
        for (NSString *btnTitle in otherButtonTitles)
        {
            [self addButtonWithTitle:btnTitle];
        }
        
		if (cancelButtonTitle)
        {
			self.cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
		}
	}
	return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	void (^block)(NSUInteger buttonIndex, UIActionSheet *actionSheet) = objc_getAssociatedObject(self, "blockCallback");
	block(buttonIndex, self);
}

@end

@implementation UIActionSheet (DKDavKit)

- (void)addButton:(NSString*)title
{
    if (title) [self addButtonWithTitle:title];
}

- (void)addCancel:(NSString*)title
{
    if (title) [self setCancelButtonIndex:[self addButtonWithTitle:title]];
}

- (void)addDestructive:(NSString*)title
{
    if (title) [self setDestructiveButtonIndex:[self addButtonWithTitle:title]];
}

- (void)addButtons:(NSArray*)btns
{
    for (NSString *btnTitle in btns)
    {
        [self addButton:btnTitle];
    }
}

@end
