//
//  DKDevice.m
//  winetubemap
//
//  Created by Aleksander Slater on 18/10/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "DKDevice.h"
#import <sys/utsname.h>

@implementation DKDevice

+ (BOOL)isTablet
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)isPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (CGFloat)screenMax
{
    CGSize s = [[UIScreen mainScreen] bounds].size;
    return MAX(s.height,s.width);
}

+ (DKDeviceType)type
{
    if ([DKDevice isTablet])
    {
        NSInteger s = self.screenMax;
        switch (s)
        {
            case 1366: return DKDeviceTypePadLarge;
            case 1024: return DKDeviceTypePad; // TODO: figure out how to distinguish Pad and PadMini
        }
        return DKDeviceTypePads;
    }
    if ([DKDevice isPhone])
    {
        NSInteger s = self.screenMax;
        switch (s)
        {
            case 480: return DKDeviceTypePhone;
            case 568: return DKDeviceTypePhone5;
            case 667: return DKDeviceTypePhone6;
            case 736: return DKDeviceTypePhone6P;
        }
    }
    
    return DKDeviceTypePhones;
}

+ (BOOL)isPhone4OrLess { return self.isPhone && self.screenMax < 568; }
+ (BOOL)isPhone5OrLess { return self.isPhone && self.screenMax <= 568; }
+ (BOOL)isPhone6OrLess { return self.isPhone && self.screenMax <= 667; }

+ (NSString*)model
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@end
