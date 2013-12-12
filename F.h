//
//  F.h
//  DAVKIT
//
//  Created by Alek Slater on 20/01/2012.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F : NSObject

+(void)f:(CGRect*)f h:(CGFloat)h y:(CGFloat)y;

+(void)f:(CGRect*)f h:(CGFloat)h;
+(void)f:(CGRect*)f w:(CGFloat)w;
+(void)f:(CGRect*)f h:(CGFloat)h w:(CGFloat)w;
+(void)f:(CGRect*)f w:(CGFloat)w h:(CGFloat)h;

+(void)f:(CGRect*)f x:(CGFloat)x;
+(void)f:(CGRect*)f y:(CGFloat)y;
+(void)f:(CGRect*)f x:(CGFloat)x y:(CGFloat)y;
+(void)f:(CGRect*)f y:(CGFloat)y x:(CGFloat)x;

+(void)f:(CGRect*)f s:(CGSize)s;
+(void)f:(CGRect*)f o:(CGPoint)o;

+(CGFloat)fdx:(CGRect)f;
+(CGFloat)fdy:(CGRect)f;

+(void)v:(UIView*)v x:(CGFloat)x;
+(void)v:(UIView*)v h:(CGFloat)h;
+(void)v:(UIView*)v w:(CGFloat)w;
+(void)v:(UIView*)v y:(CGFloat)y;
+(void)v:(UIView*)v c:(CGPoint)c;
+(void)v:(UIView*)v cy:(CGFloat)cy;
+(void)v:(UIView*)v cx:(CGFloat)cx;
+(void)v:(UIView*)v x:(CGFloat)x y:(CGFloat)y;
+(void)v:(UIView*)v s:(CGSize)s;
+(void)v:(UIView*)v o:(CGPoint)o;
+(void)v:(UIView*)v f:(CGRect)f;
+(void)v:(UIView*)v w:(CGFloat)w h:(CGFloat)h;
+(void)v:(UIView*)v x:(CGFloat)x w:(CGFloat)w;

+(CGFloat)dx:(UIView*)v;
+(CGFloat)dy:(UIView*)v;
+(CGFloat)h:(UIView*)v;
+(CGFloat)w:(UIView*)v;
+(CGFloat)y:(UIView*)v;
+(CGFloat)x:(UIView*)v;
+(CGPoint)o:(UIView*)v;
+(CGSize)s:(UIView*)v;

+(void)round:(UIView*)v;
+ (CGRect)aspectFittedRect:(CGSize)imgSize max:(CGRect)maxRect;
+ (CGRect)flipSize:(CGRect)fr;

@end
