//
//  DKUtils.m
//  Constructor
//
//  Created by Aleksander Slater on 14/08/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import "DKUtils.h"
#import <objc/runtime.h>

@implementation DKUtils

+ (NSString*)argumentTypeStringFromArgumentType:(char*)c
{
    NSString *s = [NSString stringWithUTF8String:c];
    if ([s isEqualToString:@"@"])
        return @"Id";
    if ([s isEqualToString:@"#"])
        return @"Class";
    if ([s isEqualToString:@":"])
        return @"Selector";
    if ([s isEqualToString:@"c"])
        return @"Char";
    if ([s isEqualToString:@"C"])
        return @"Unsigned Char";
    if ([s isEqualToString:@"s"])
        return @"Short";
    if ([s isEqualToString:@"S"])
        return @"Unsigned short";
    if ([s isEqualToString:@"i"])
        return @"Integer";
    if ([s isEqualToString:@"I"])
        return @"Unsigned Integer";
    if ([s isEqualToString:@"l"])
        return @"Long";
    if ([s isEqualToString:@"L"])
        return @"Unsigned Long";
    if ([s isEqualToString:@"q"])
        return @"Long long";
    if ([s isEqualToString:@"Q"])
        return @"Unsigned Long long";
    if ([s isEqualToString:@"f"])
        return @"Float";
    if ([s isEqualToString:@"d"])
        return @"Double";
    if ([s isEqualToString:@"b"])
        return @"Bit";
    if ([s isEqualToString:@"B"])
        return @"Bool";
    if ([s isEqualToString:@"v"])
        return @"Void";
    if ([s isEqualToString:@"?"])
        return @"Undefined";
    if ([s isEqualToString:@"^"])
        return @"_C_PTR";
    if ([s isEqualToString:@"*"])
        return @"_C_CHARPTR";
    if ([s isEqualToString:@"%"])
        return @"Atom";
    if ([s isEqualToString:@"["])
        return @"_C_ARY_B";
    if ([s isEqualToString:@"]"])
        return @"_C_ARY_E";
    if ([s isEqualToString:@"("])
        return @"_C_UNION_B";
    if ([s isEqualToString:@")"])
        return @"_C_UNION_E";
    if ([s isEqualToString:@"{"])
        return @"_C_STRUCT_B";
    if ([s isEqualToString:@"}"])
        return @"_C_STRUCT_E";
    if ([s isEqualToString:@"!"])
        return @"Vector";
    if ([s isEqualToString:@"r"])
        return @"Constant";

    return @"Unknown";
}

+ (void)listMethodsForObject:(id)obj
{
    unsigned int numberOfMethods = 0;
    Method * mlist = class_copyMethodList(object_getClass(obj), &numberOfMethods);
    
    for(int i=0; i<numberOfMethods; i++)
    {
        Method method = mlist[i];
        SEL selector = method_getName(method);
        const char * name = sel_getName(selector);
        NSLog(@"Method no #%d: %s", i, name);
//        int numberOfArguments = method_getNumberOfArguments(method);
//        for (int j=0; j<numberOfArguments; j++)
//        {
//            char *argType = method_copyArgumentType(method,j);
//            NSLog(@"  %@",[DKUtils argumentTypeStringFromArgumentType:argType]);
//            free(argType);
//        }
    }
    
    free(mlist);
    
    unsigned int numberOfProperties = 0;
    objc_property_t * plist = class_copyPropertyList(object_getClass(obj), &numberOfProperties);
    
    for(int i=0; i<numberOfProperties; i++)
    {
        objc_property_t property = plist[i];
        const char * attr = property_getAttributes(property);
        NSLog(@"Property no #%d: %s", i, attr);
    }
    
    free(plist);
}

+ (void)setBlock:(id)block withKey:(const void *)key forObject:(id)object
{
    objc_setAssociatedObject(object,key,[block copy],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)getBlockForObject:(id)object withKey:(const void *)key
{
    return objc_getAssociatedObject(object, key);
}

@end
