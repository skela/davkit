//
//  JSON.swift
//  Constructor
//
//  Created by Aleksander Slater on 06/03/2016.
//  Copyright © 2016 IntroLabs. All rights reserved.
//

import Foundation

public class JSON
{
    class func fromString(str:String?,encoding:NSStringEncoding=NSUTF8StringEncoding) -> NSDictionary?
    {
        if str == nil { return nil }
        return fromData(str!.dataUsingEncoding(encoding))
    }
    
    class func fromData(data:NSData?) -> NSDictionary?
    {
        if data == nil { return nil }
        do
        {
            let optns = NSJSONReadingOptions(rawValue:0)
            let js = try NSJSONSerialization.JSONObjectWithData(data!,options:optns)
            guard let jsdict : NSDictionary = js as? NSDictionary else
            {
                print("DavKit.JSON: Not a Dictionary")
                return nil
            }
            return jsdict
        }
        catch let JSONError as NSError
        {
            print("DavKit.JSON: \(JSONError)")
        }
        return nil
    }
    
    class func fromStringToArray(str:String?,encoding:NSStringEncoding=NSUTF8StringEncoding) -> NSArray?
    {
        if str == nil { return nil }
        return fromDataToArray(str!.dataUsingEncoding(encoding))
    }
    
    class func fromDataToArray(data:NSData?) -> NSArray?
    {
        if data == nil { return nil }
        do
        {
            let optns = NSJSONReadingOptions(rawValue:0)
            let js = try NSJSONSerialization.JSONObjectWithData(data!,options:optns)
            guard let jsarr : NSArray = js as? NSArray else
            {
                print("DavKit.JSON: Not an Array")
                return nil
            }
            return jsarr
        }
        catch let JSONError as NSError
        {
            print("DavKit.JSON: \(JSONError)")
        }
        return nil
    }
    
    class func toData(any:AnyObject) -> NSData?
    {
        let optns = NSJSONWritingOptions(rawValue:0)
        do
        {
            let data = try NSJSONSerialization.dataWithJSONObject(any,options:optns)
            return data
        }
        catch let er as NSError
        {
            print("DavKit.JSON Serialization Failed: \(er)")
        }
        return nil
    }
    
    class func toString(any:AnyObject,encoding:NSStringEncoding=NSUTF8StringEncoding) -> String?
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
    public var fromJson : [String:NSObject]?
    {
        let d = JSON.fromString(self)
        return d as? [String:NSObject]
    }
}

public extension Dictionary where Key:JSONKeyType,Value:AnyObject
{
    public var toJson : String?
    {
        let any = self as! AnyObject
        return JSON.toString(any)
    }
}

public extension Dictionary where Key:JSONKeyType,Value:NSObject
{
    public var toJsonLegacy : String?
    {
        let any = self as! AnyObject
        return JSON.toString(any)
    }
}

public extension NSDictionary
{
    public var toJson : String?
    {
        return JSON.toString(self)
    }
}

public extension NSData
{
    public var fromJson : [String:NSObject]?
    {
        let d = JSON.fromData(self)
        return d as? [String:NSObject]
    }
}
