
import Foundation
import UIKit

public class DKParser
{
    public class func getObject(d:NSDictionary?,ofClass classe:AnyClass,forKey key:String,fallback:AnyObject?) -> AnyObject?
    {
        if let od = d
        {
            if let obj = od.objectForKey(key)
            {
                if obj.isKindOfClass(classe) { return obj }
            }
        }
        return fallback
    }
    
    public class func getObject(d:NSDictionary?,ofClass classe:AnyClass,forKeys keys:Array<String>,fallback:AnyObject?) -> AnyObject?
    {
        for key in keys
        {
            if let od = d
            {
                if let obj = od.objectForKey(key)
                {
                    if obj.isKindOfClass(classe) { return obj }
                }
            }
        }
        return fallback
    }
    
    public class func getSafeNumber(d:NSDictionary?,forKey key:String, fallback:NSNumber) -> NSNumber
    {
        if let ret = getNumber(d, forKey: key, fallback: fallback)
        {
            return ret
        }
        return fallback
    }
    
    public class func getSafeNumber(d:NSDictionary?,forKeys keys:Array<String>,fallback:NSNumber) -> NSNumber
    {
        if let ret = getNumber(d, forKeys: keys, fallback: fallback)
        {
            return ret
        }
        return fallback
    }
    
    public class func getValue(d:NSDictionary?,forKey key:String, fallback:NSValue?) -> NSValue?
    {
        return getObject(d,ofClass:NSValue.self,forKey:key,fallback:fallback) as? NSValue
    }
    
    public class func getArray(d:NSDictionary?,forKey key:String, fallback:NSArray?) -> NSArray?
    {
        return getObject(d,ofClass:NSArray.self,forKey:key,fallback:fallback) as? NSArray
    }
    
    public class func getDictionary(d:NSDictionary?,forKey key:String, fallback:NSDictionary?) -> NSDictionary?
    {
        return getObject(d,ofClass:NSDictionary.self,forKey:key,fallback:fallback) as? NSDictionary
    }
    
    public class func getString(d:NSDictionary?,forKey key:String, fallback:String?) -> String?
    {
        return getObject(d,ofClass:object_getClass(""),forKey:key,fallback:fallback) as? String
    }
    
    public class func getNumber(d:NSDictionary?,forKey key:String, fallback:NSNumber?) -> NSNumber?
    {
        return getObject(d,ofClass:NSNumber.self,forKey:key,fallback:fallback) as? NSNumber
    }
    
    public class func getInteger(d:NSDictionary?,forKey key:String, fallback:Int) -> Int
    {
        return getSafeNumber(d, forKey: key, fallback:fallback).integerValue
    }
    
    public class func getBool(d:NSDictionary?,forKey key:String, fallback:Bool) -> Bool
    {
        return getSafeNumber(d, forKey: key, fallback:fallback).boolValue
    }
    
    public class func getFloat(d:NSDictionary?,forKey key:String, fallback:Float) -> Float
    {
        return getSafeNumber(d, forKey: key, fallback:fallback).floatValue
    }
    
    public class func getDouble(d:NSDictionary?,forKey key:String, fallback:Double) -> Double
    {
        return getSafeNumber(d, forKey: key, fallback:fallback).doubleValue
    }
    
    public class func getInt(d:NSDictionary?,forKey key:String, fallback:Int32) -> Int32
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(int:fallback)).intValue
    }
    
    public class func getLongLong(d:NSDictionary?,forKey key:String, fallback:Int64) -> Int64
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(longLong:fallback)).longLongValue
    }
    
    public class func getValue(d:NSDictionary?,forKeys keys:Array<String>, fallback:NSValue?) -> NSValue?
    {
        return getObject(d,ofClass:NSValue.self,forKeys:keys,fallback:fallback) as? NSValue
    }
    
    public class func getArray(d:NSDictionary?,forKeys keys:Array<String>, fallback:NSArray?) -> NSArray?
    {
        return getObject(d,ofClass:NSArray.self,forKeys:keys,fallback:fallback) as? NSArray
    }
    
    public class func getDictionary(d:NSDictionary?,forKeys keys:Array<String>, fallback:NSDictionary?) -> NSDictionary?
    {
        return getObject(d,ofClass:NSDictionary.self,forKeys:keys,fallback:fallback) as? NSDictionary
    }
    
    public class func getString(d:NSDictionary?,forKeys keys:Array<String>, fallback:String?) -> String?
    {
        return getObject(d,ofClass:object_getClass(""),forKeys:keys,fallback:fallback) as? String
    }
    
    public class func getNumber(d:NSDictionary?,forKeys keys:Array<String>, fallback:NSNumber?) -> NSNumber?
    {
        return getObject(d,ofClass:NSNumber.self,forKeys:keys,fallback:fallback) as? NSNumber
    }
    
    public class func getInteger(d:NSDictionary?,forKeys keys:Array<String>, fallback:Int) -> Int
    {
        return getSafeNumber(d, forKeys:keys, fallback:fallback).integerValue
    }
    
    public class func getBool(d:NSDictionary?,forKeys keys:Array<String>, fallback:Bool) -> Bool
    {
        return getSafeNumber(d, forKeys: keys, fallback:fallback).boolValue
    }
    
    public class func getFloat(d:NSDictionary?,forKeys keys:Array<String>, fallback:Float) -> Float
    {
        return getSafeNumber(d, forKeys: keys, fallback:fallback).floatValue
    }
    
    public class func getDouble(d:NSDictionary?,forKeys keys:Array<String>, fallback:Double) -> Double
    {
        return getSafeNumber(d, forKeys: keys, fallback:fallback).doubleValue
    }
    
    public class func getInt(d:NSDictionary?,forKeys keys:Array<String>, fallback:Int32) -> Int32
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(int:fallback)).intValue
    }
    
    public class func getLongLong(d:NSDictionary?,forKeys keys:Array<String>, fallback:Int64) -> Int64
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(longLong:fallback)).longLongValue
    }
}
