//
//  F.m
//  DAVKIT
//
//  Created by Alek Slater on 20/01/2012.
//  Copyright (c) 2013 Davincium. All rights reserved.
//

#import "F.h"

@implementation F

+(void)f:(CGRect*)f h:(CGFloat)h y:(CGFloat)y{f->origin.y=y;f->size.height=h;}

+(void)f:(CGRect*)f h:(CGFloat)h{f->size.height=h;}
+(void)f:(CGRect*)f w:(CGFloat)w{f->size.width=w;}
+(void)f:(CGRect*)f h:(CGFloat)h w:(CGFloat)w{f->size.height=h;f->size.width=w;}
+(void)f:(CGRect*)f w:(CGFloat)w h:(CGFloat)h{f->size.height=h;f->size.width=w;}

+(void)f:(CGRect*)f x:(CGFloat)x{f->origin.x=x;}
+(void)f:(CGRect*)f y:(CGFloat)y{f->origin.y=y;}
+(void)f:(CGRect*)f x:(CGFloat)x y:(CGFloat)y{f->origin.x=x;f->origin.y=y;}
+(void)f:(CGRect*)f y:(CGFloat)y x:(CGFloat)x{f->origin.x=x;f->origin.y=y;}

+(void)f:(CGRect*)f s:(CGSize)s{f->size=s;}
+(void)f:(CGRect*)f o:(CGPoint)o{f->origin=o;}

+(CGFloat)fdx:(CGRect)f{return f.size.width+f.origin.x;}
+(CGFloat)fdy:(CGRect)f{return f.size.height+f.origin.y;}

+(void)v:(UIView*)v x:(CGFloat)x{CGRect f; f=v.frame; [F f:&f x:x]; v.frame=f;}
+(void)v:(UIView*)v y:(CGFloat)y{CGRect f; f=v.frame; [F f:&f y:y]; v.frame=f;}
+(void)v:(UIView*)v h:(CGFloat)h{CGRect f; f=v.frame; [F f:&f h:h]; v.frame=f;}
+(void)v:(UIView*)v w:(CGFloat)w{CGRect f; f=v.frame; [F f:&f w:w]; v.frame=f;}
+(void)v:(UIView*)v w:(CGFloat)w h:(CGFloat)h{CGRect f; f=v.frame; f.size.width=w;f.size.height=h; v.frame=f;}
+(void)v:(UIView*)v x:(CGFloat)x w:(CGFloat)w{CGRect f; f=v.frame; f.origin.x=x; f.size.width=w; v.frame=f;}
+(void)v:(UIView*)v cy:(CGFloat)cy{CGPoint c = v.center; c.y = cy; v.center = c;}
+(void)v:(UIView*)v cx:(CGFloat)cx{CGPoint c = v.center; c.x = cx; v.center = c;}
+(void)v:(UIView*)v c:(CGPoint)c{v.center = c;}
+(void)v:(UIView*)v x:(CGFloat)x y:(CGFloat)y{CGRect f; f=v.frame; f.origin.x=x; f.origin.y=y; v.frame=f;}
+(void)v:(UIView*)v s:(CGSize)s{CGRect f; f=v.frame; f.size=s; v.frame=f;}
+(void)v:(UIView*)v o:(CGPoint)o{CGRect f; f=v.frame; f.origin=o; v.frame=f;}
+(void)v:(UIView*)v f:(CGRect)f{v.frame=f;}

+(CGFloat)dx:(UIView*)v{return [F fdx:v.frame];}
+(CGFloat)dy:(UIView*)v{return [F fdy:v.frame];}
+(CGFloat)h:(UIView*)v{return v.frame.size.height;}
+(CGFloat)w:(UIView*)v{return v.frame.size.width;}
+(CGFloat)y:(UIView*)v{return v.frame.origin.y;}
+(CGFloat)x:(UIView*)v{return v.frame.origin.x;}
+(CGPoint)o:(UIView*)v{return v.frame.origin;}
+(CGSize)s:(UIView*)v{return v.frame.size;}

+(void)round:(UIView*)v
{
    CGRect f=v.frame;
    f.origin.y=roundf(f.origin.y);
    f.origin.x=roundf(f.origin.x);
    v.frame=f;
}

+ (CGRect)aspectFittedRect:(CGSize)imgSize max:(CGRect)maxRect
{
    float originalAspectRatio = imgSize.width / imgSize.height;
	float maxAspectRatio = maxRect.size.width / maxRect.size.height;
    
	CGRect newRect = maxRect;
	if (originalAspectRatio > maxAspectRatio)
    {
		newRect.size.height = maxRect.size.width * imgSize.height / imgSize.width;
		newRect.origin.y += (maxRect.size.height - newRect.size.height)/2.0;
	}
    else
    {
		newRect.size.width = maxRect.size.height  * imgSize.width / imgSize.height;
		newRect.origin.x += (maxRect.size.width - newRect.size.width)/2.0;
	}
    
	return CGRectIntegral(newRect);
}

@end
