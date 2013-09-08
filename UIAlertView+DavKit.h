//
//  UIAlertView+DavKit.h
//  DropBeacon
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (DavKit) <UIAlertViewDelegate>

- (id)initWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
