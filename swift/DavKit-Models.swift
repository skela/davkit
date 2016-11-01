//
//  DavKit.swift
//  DKSandbox
//
//  Created by Aleksander Slater on 06/04/2016.
//  Copyright © 2016 Davincium. All rights reserved.
//

import Foundation

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
