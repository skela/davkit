//
//  DavKit.swift
//  DKSandbox
//
//  Created by Aleksander Slater on 06/04/2016.
//  Copyright © 2016 Davincium. All rights reserved.
//

import Foundation

extension DKParser
{
    public class func getDict(_ d: [String : Any]?, forKey key: String, fallback:[String : Any]?) -> [String : Any]?
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

extension DKParser
{
    open class func setDateId(_ val:DKDateId?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setString(val?.value,forKey:key,inDict:dict)
    }
    
    open class func setDateId(_ val:Date?,withId id:String?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        if val == nil || id == nil { setString(nil,forKey:key,inDict:dict) }
        else { setDateId(DKDateId(date:val!,andId:id!),forKey:key,inDict:dict) }
    }
    
    open class func getDateId(_ d:[AnyHashable:Any]?,forKey key:String, fallback:DKDateId?) -> DKDateId?
    {
        if let s = getString(d,forKey:key,fallback:nil)
        {
            if let d = DKDateId(string:s)
            {
                return d
            }
        }
        return fallback
    }
}

public class DKDateId : NSObject
{
    public var value: String?
    
    public convenience init?(string s: String?)
    {
        self.init()
        value = s
        
        if id == nil || date == nil { return nil }
    }
    
    public override init()
    {
        
    }
    
    public convenience init(date aDate: Date, andId id: String)
    {
        self.init()
        setDate(aDate,andId:id)
    }
    
    public func setDate(_ date: Date, andId id: String)
    {
        value = valueFromComponents(date,id:id)
    }
    
    public var id : String?
    {
        if let c = components { if c.count == 2 { return c[1] } }
        return nil
    }
    
    // For objc legacy purposes
    public var Id : String?
    {
        return id
    }
    
    public var date : Date?
    {
        if let c = components
        {
            if c.count == 2
            {
                if let d = Double(c[0])
                {
                    return Date(timeIntervalSince1970:d)
                }
            }
        }
        return nil
    }
    
    var components : [String]?
    {
        return value?.components(separatedBy:"|")
    }
    
    func valueFromComponents(_ date:Date,id:String) -> String
    {
        return String(format:"%g|%@",date.timeIntervalSince1970,id)
    }
}
