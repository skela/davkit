//
//  DKDevice.h
//  winetubemap
//
//  Created by Aleksander Slater on 18/10/2014.
//  Copyright (c) 2014 Appetise. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
