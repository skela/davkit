//
//  DKApp.m
//  DavKit
//
//  Created by Aleksander Slater on 11/10/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "DKApp.h"

@implementation DKApp

+ (NSString *)version
{
    return [NSString stringWithFormat:@"%@-%@",
			[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
			[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
			];
}

+ (NSString *)versionNumber
{
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSString *strVersionNumber = [infoDictionary valueForKey:@"CFBundleShortVersionString"];
	if (strVersionNumber!=nil)
		return strVersionNumber;
	else
		return @"";
}

+ (NSString *)buildNumber
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSString *strVersionNumber = [infoDictionary valueForKey:@"CFBundleVersion"];
	if (strVersionNumber!=nil)
		return strVersionNumber;
	else
		return @"";
}

@end
