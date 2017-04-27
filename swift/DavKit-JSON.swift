//
//  JSON.swift
//  Constructor
//
//  Created by Aleksander Slater on 06/03/2016.
//  Copyright © 2016 IntroLabs. All rights reserved.
//

import Foundation

open class JSON
{
    internal class func log(_ msg:String)
    {
        DavKit.log("JSON",msg)
    }
    
    class func fromString(_ str:String?,encoding:String.Encoding=String.Encoding.utf8) -> NSDictionary?
    {
        if str == nil { return nil }
        return fromData(str!.data(using: encoding))
    }
    
    class func fromData(_ data:Data?) -> NSDictionary?
    {
        if data == nil { return nil }
        do
        {
            let optns = JSONSerialization.ReadingOptions(rawValue:0)
            let js = try JSONSerialization.jsonObject(with: data!,options:optns)
            guard let jsdict : NSDictionary = js as? NSDictionary else
            {
                log("Not a Dictionary")
                return nil
            }
            return jsdict
        }
        catch let JSONError as NSError
        {
            log("\(JSONError)")
        }
        return nil
    }
    
    class func fromStringToArray(_ str:String?,encoding:String.Encoding=String.Encoding.utf8) -> NSArray?
    {
        if str == nil { return nil }
        return fromDataToArray(str!.data(using: encoding))
    }
    
    class func fromDataToArray(_ data:Data?) -> NSArray?
    {
        if data == nil { return nil }
        do
        {
            let optns = JSONSerialization.ReadingOptions(rawValue:0)
            let js = try JSONSerialization.jsonObject(with: data!,options:optns)
            guard let jsarr : NSArray = js as? NSArray else
            {
                log("Not an Array")
                return nil
            }
            return jsarr
        }
        catch let JSONError as NSError
        {
            log("\(JSONError)")
        }
        return nil
    }
    
    class func toData(_ any:Any) -> Data?
    {
        let optns = JSONSerialization.WritingOptions(rawValue:0)
        do
        {
            let data = try JSONSerialization.data(withJSONObject: any,options:optns)
            return data
        }
        catch let er as NSError
        {
            log("Serialization Failed: \(er)")
        }
        return nil
    }
    
    class func toString(_ any:Any,encoding:String.Encoding=String.Encoding.utf8) -> String?
    {
        if let data = toData(any)
        {
            return String(data:data,encoding:encoding)
        }
        return nil
    }
}

public protocol JSONKeyType: Hashable
{
    var stringValue: String { get }
}

extension String : JSONKeyType
{
    public var stringValue: String
    {
        return self
    }
}

extension String
{
    public var fromJson : [String:Any]?
    {
        let d = JSON.fromString(self)
        return d as? [String:Any]
    }
    
    public var fromJsonArray : [Any]?
    {
        let d = JSON.fromStringToArray(self)
        return d as? [Any]
    }
}

public extension Dictionary where Key:JSONKeyType,Value:Any
{
    public var toJson : String?
    {
        let any = self as Any
        return JSON.toString(any)
    }
    
    public var toJsonLegacy : String?
    {
        let any = self as Any
        return JSON.toString(any)
    }
}

public extension ExpressibleByArrayLiteral where Element == [String:Any]
{
    public var toJson : String?
    {
        let any = self as Any
        return JSON.toString(any)
    }
}

//public extension NSDictionary
//{
//    public var toJson : String?
//    {
//        return JSON.toString(self)
//    }
//}

public extension Data
{
    public var fromJson : [String:Any]?
    {
        let d = JSON.fromData(self)
        return d as? [String:Any]
    }
    
    public var fromJsonArray : [Any]?
    {
        let d = JSON.fromDataToArray(self)
        return d as? [Any]
    }
}
