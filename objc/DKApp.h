//
//  DKApp.h
//  DavKit
//
//  Created by Aleksander Slater on 11/10/2013.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKApp : NSObject

+ (nonnull NSString *)version;
+ (nonnull NSString *)versionNumber;
+ (nonnull NSString *)buildNumber;

@end
