//
//  UIAlertView+DavKit.m
//  DropBeacon
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "UIAlertView+DavKit.h"
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
	block(buttonIndex, self);
}

@end

