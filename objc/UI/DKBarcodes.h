//
//  DKBarcodes.h
//  Constructor
//
//  Created by Aleksander Slater on 21/07/2016.
//  Copyright © 2016 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DKBarcodes : NSObject

+ (nullable UIImage*)createQRcode:(nullable NSString*)text size:(CGFloat)size;
+ (nullable NSString*)scanQRCode:(nullable UIImage*)image;

@end
