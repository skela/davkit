//
//  UIView+DavKit.m
//  DavKit
//
//  Created by Aleksander Slater on 25/02/2014.
//  Copyright (c) 2014 Davincium. All rights reserved.
//

#import "UIView+DavKit.h"

@implementation UIView (DavKit)

- (NSString*)frameDescription
{
    return [NSString stringWithFormat:@"[%g,%g,%g,%g]",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height];
}

- (NSString*)viewDescription
{
    return [NSString stringWithFormat:@"f:%@ t:%@",self.frameDescription,NSStringFromCGAffineTransform(self.transform)];
}

@end

@implementation UITableView (DavKit)

- (NSIndexPath*)nextIndexPath:(NSIndexPath*)indexPath
{
    int numOfSections = self.numberOfSections;
    int nextSection = ((indexPath.section + 1) % numOfSections);
    
    if ((indexPath.row + 1) == [self numberOfRowsInSection:indexPath.section])
    {
        return [NSIndexPath indexPathForRow:0 inSection:nextSection];
    }
    else
    {
        return [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    }
}

- (NSIndexPath*)previousIndexPath:(NSIndexPath*)indexPath
{
    int numOfSections = self.numberOfSections;
    int nextSection = ((indexPath.section - 1) % numOfSections);
    
    if ((indexPath.row - 1) < 0)
    {
        if (indexPath.row==0 && indexPath.section==0)
        {
            int nextRow = 0;
            nextSection = numOfSections-1;
            if (nextSection<0)
                nextSection = 0;
            nextRow = [self numberOfRowsInSection:nextSection] - 1;
            if (nextRow<0)
                nextRow = 0;
            return [NSIndexPath indexPathForRow:nextRow inSection:nextSection];
        }
        else
        {
            return [NSIndexPath indexPathForRow:0 inSection:nextSection];
        }
    }
    else
    {
        return [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
    }
}

@end