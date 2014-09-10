//
//  DKUtils.h
//  Constructor
//
//  Created by Aleksander Slater on 14/08/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKUtils : NSObject

+ (void)listMethodsForObject:(id)obj;

+ (void)setBlock:(id)block withKey:(const void *)key forObject:(id)object;
+ (id)getBlockForObject:(id)object withKey:(const void *)key;

@end
