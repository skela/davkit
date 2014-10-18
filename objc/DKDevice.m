//
//  DKDevice.m
//  winetubemap
//
//  Created by Aleksander Slater on 18/10/2014.
//  Copyright (c) 2014 Appetise. All rights reserved.
//

#import "DKDevice.h"

@implementation DKDevice

+ (BOOL)isTablet
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

@end
