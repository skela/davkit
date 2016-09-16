//
//  UIAlertView+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 08/09/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DKStringBlock)( NSString* _Nonnull );
typedef void(^DKTextFieldConfiguratorBlock)( UITextField* _Nonnull );
typedef void(^DKTextFieldDoneBlock)( id _Nonnull,NSString *_Nullable );

@interface DKAlertController : NSObject

- (nonnull instancetype)initWithTitle:(nullable NSString*)title;
- (nonnull instancetype)initWithTitle:(nullable NSString*)title andMessage:(nullable NSString*)msg;

- (void)addButton:(nonnull NSString*)btn action:(nullable DKStringBlock)action;
- (void)addCancel:(nonnull NSString*)cancel;
- (void)addCancel:(nonnull NSString*)cancel action:(nullable DKStringBlock)action;

- (void)button:(nonnull NSString*)btn action:(nullable DKStringBlock)action;
- (void)cancel:(nonnull NSString*)cancel action:(nullable DKStringBlock)action;

- (void)show:(nonnull UIViewController*)parent;
- (void)show:(nonnull UIViewController*)parent container:(nullable id)container;
- (void)show:(nonnull UIViewController*)parent container:(nullable id)container animated:(BOOL)animated;

- (void)addTextField:(nonnull DKTextFieldConfiguratorBlock)configurator;
- (void)addTextDone:(nonnull NSString*)button done:(nullable DKTextFieldDoneBlock)done;
- (nonnull UITextField*)textField:(NSInteger)index;

- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

@end

@interface DKAlert : DKAlertController <UIAlertViewDelegate>

@end

@interface DKSheet : DKAlertController <UIActionSheetDelegate>

- (void)addDestructive:(nonnull NSString*)destructive;
- (void)addDestructive:(nonnull NSString*)destructive action:(nullable DKStringBlock)action;
- (void)addButtons:(nonnull NSArray*)btns action:(nullable DKStringBlock)action;

- (void)destructive:(nonnull NSString*)destructive action:(nullable DKStringBlock)action;
- (void)buttons:(nonnull NSArray*)btns action:(nullable DKStringBlock)action;

@end
