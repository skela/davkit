//
//  DKDevice.h
//  winetubemap
//
//  Created by Aleksander Slater on 18/10/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DKDeviceType)
{
    DKDeviceTypePhone,
    DKDeviceTypePhone5,
    DKDeviceTypePhone6,
    DKDeviceTypePhone6P,
    DKDeviceTypePad,
    DKDeviceTypePadMini
};

@interface DKDevice : NSObject
+ (BOOL)isTablet;
+ (BOOL)isPhone;
+ (BOOL)isPhone4OrLess;
+ (BOOL)isPhone5OrLess;
+ (BOOL)isPhone6OrLess;
+ (DKDeviceType)type;
+ (NSString*)model;
@end
