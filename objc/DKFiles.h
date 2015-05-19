//
//  DKFiles.h
//  Constructor
//
//  Created by Aleksander Slater on 19/05/2015.
//  Copyright (c) 2015 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKFiles : NSObject
+ (NSString*)md5ForFileAtPath:(NSString*)path;
+ (NSString*)md5ForFileAtURL:(NSURL*)url;
@end
