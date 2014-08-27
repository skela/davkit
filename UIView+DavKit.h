//
//  UIView+DavKit.h
//  DavKit
//
//  Created by Aleksander Slater on 25/02/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DavKit)

- (NSString*)frameDescription;
- (NSString*)viewDescription;

@end

@interface UITableView (DavKit)
- (NSIndexPath*)nextIndexPath:(NSIndexPath*)indexPath;
- (NSIndexPath*)previousIndexPath:(NSIndexPath*)indexPath;
@end
