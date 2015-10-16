
import Foundation
import UIKit

protocol IDKList : NSObjectProtocol
{
    func values() -> NSArray?
}

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
    
    public class func getDate(d:NSDictionary?,forKey key:String,fallback:NSDate?) -> NSDate?
    {
        if let n = d?.objectForKey(key) as? NSNumber
        {
            return NSDate(timeIntervalSince1970:n.doubleValue)
        }
        if let date = d?.objectForKey(key) as? NSDate
        {
            return date
        }
        return fallback
    }
    
    public class func getDate(d:NSDictionary?,forKeys keys:Array<String>,fallback:NSDate?) -> NSDate?
    {
        for key in keys
        {
            if let od = d
            {
                if let n = od.objectForKey(key) as? NSNumber
                {
                    return NSDate(timeIntervalSince1970:n.doubleValue)
                }
                if let date = od.objectForKey(key) as? NSDate
                {
                    return date
                }
            }
        }
        return fallback
    }
    
    public class func getList(d:NSDictionary?,forKey key:String, fallback:NSArray?) -> NSArray?
    {
        if let classe = NSClassFromString("DBList")
        {
            if let obj = getObject(d,ofClass:classe,forKey:key,fallback:nil) as? IDKList
            {
                return obj.values()
            }
        }
        return getArray(d,forKey:key,fallback:fallback)
    }
    
    // MARK: Setters
    
    public class func setObject(val:AnyObject?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:AnyObject?)
    {
        if let v = val
        {
            dict?.setObject(v,forKey:key)
        }
        else
        {
            if let fb = replacement
            {
                dict?.setObject(fb,forKey:key)
            }
            else
            {
                dict?.removeObjectForKey(key)
            }
        }
    }
    
    public class func setNumber(val:NSNumber?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:NSNumber?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    public class func setString(val:String?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:String?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    public class func setDictionary(val:NSDictionary?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:NSDictionary?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    public class func setArray(val:NSArray?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:NSArray?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    public class func setInt(val:Int32,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(int:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    public class func setInteger(val:Int,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(integer:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    public class func setBool(val:Bool,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(bool:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    public class func setDouble(val:Double,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(double:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    public class func setFloat(val:Float,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(float:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    public class func setSelector(val:Selector?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        if let s = val
        {
            setObject(NSStringFromSelector(s), forKey:key, inDict:dict, replacement:nil)
        }
        else
        {
            setObject(nil, forKey:key, inDict:dict, replacement:nil)
        }
    }
    
    public class func setDate(val:NSDate?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:NSDate?=nil)
    {
        if let v = val
        {
            setObject(NSNumber(double:v.timeIntervalSince1970), forKey:key, inDict:dict, replacement:replacement)
        }
        else
        {
            setObject(val, forKey:key, inDict:dict, replacement:replacement)
        }
    }
}
