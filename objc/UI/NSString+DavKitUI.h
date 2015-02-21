//
//  NSString+DavKitUI.h
//  Constructor
//
//  Created by Aleksander Slater on 29/08/2014.
//  Copyright (c) 2014 IntroLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DavKitUI)

- (CGSize)sizeUsingFont:(UIFont *)font;
- (CGSize)sizeUsingFont:(UIFont*)font constrainedToSize:(CGSize)constraint lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (NSAttributedString*)bold:(NSString*)subString;
- (NSAttributedString*)bold:(NSString*)subString size:(CGFloat)size;
- (NSAttributedString*)strikethrough:(NSString*)subString;

@end
