//
//  DavKit.swift
//  DKSandbox
//
//  Created by Aleksander Slater on 06/04/2016.
//  Copyright © 2016 Davincium. All rights reserved.
//

import Foundation

class DavKit
{
    class func log(_ component:String,_ msg:String)
    {
        print("DavKit.\(component): \(msg)")
    }
}

extension DKParser
{
    public class func getDict(_ d: [AnyHashable : Any]?, forKey key: String, fallback:[String : Any]?) -> [String : Any]?
    {
        return getDictionary(d,forKey:key,fallback:fallback) as? [String:Any]
    }
}

public extension Dictionary where Key:Comparable,Value:Any
{
    public func getDate(_ key:String,fallback:Date?) -> Date?
    {
        return DKParser.getDate(self,forKey:key,fallback:fallback)
    }
}
