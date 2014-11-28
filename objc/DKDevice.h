//
//  DKDevice.h
//  winetubemap
//
//  Created by Aleksander Slater on 18/10/2014.
//  Copyright (c) 2014 Appetise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    DKDeviceTypeiPhone,
    DKDeviceTypeiPhone5,
    DKDeviceTypeiPhone6,
    DKDeviceTypeiPhone6P,
    DKDeviceTypeiPad,
    DKDeviceTypeiPadMini
} DKDeviceType;

@interface DKDevice : NSObject
+ (BOOL)isTablet;
+ (BOOL)isPhone;
+ (BOOL)isPhone4OrLess;
+ (BOOL)isPhone5OrLess;
+ (BOOL)isPhone6OrLess;
+ (DKDeviceType)type;
@end
