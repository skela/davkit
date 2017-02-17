//
//  DavKit-UI.swift
//  Constructor
//
//  Created by Aleksander Slater on 17/02/2017.
//  Copyright © 2017 IntroLabs. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func roundOff()
    {
        var f = frame
        f.origin.y = round(f.origin.y)
        f.origin.x = round(f.origin.x)
        f.size.width = round(f.size.width)
        f.size.height = round(f.size.height)
        self.frame=f
    }
}

extension UIScrollView
{
    var isAtBottom : Bool
    {
        return isAtBottomish(0)
    }
    
    func isAtBottomish(_ fudgeFactor:CGFloat) -> Bool
    {
        if contentOffset.y + fudgeFactor >= (contentSize.height - frame.size.height)
        {
            return true
        }
        return false
    }
}
