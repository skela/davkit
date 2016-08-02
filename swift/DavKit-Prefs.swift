//
//  DavKit.swift
//  DKSandbox
//
//  Created by Aleksander Slater on 06/04/2016.
//  Copyright © 2016 Davincium. All rights reserved.
//

import Foundation

public protocol DKPrefsContainer
{
    func synchronize() -> Bool
    func objectForKey(key:String) -> AnyObject?
    func removeObjectForKey(key:String)
    func setObject(obj:AnyObject?,forKey:String)
}

extension NSUserDefaults : DKPrefsContainer
{
    
}

public class DKPrefs : NSObject
{
    public class func clear()
    {
        
    }
    
    //MARK: Generic
    
    public class var defaults : DKPrefsContainer
    {
        return NSUserDefaults.standardUserDefaults()
    }
    
    public class func sync() -> Bool
    {
        return defaults.synchronize()
    }
    
    public class func getObjectOfClass(classe:AnyClass,forKey key:String,defaultValue def:AnyObject?) -> AnyObject?
    {
        let obj = defaults.objectForKey(key)
        if obj == nil || !obj!.isKindOfClass(classe)
        {
            return def
        }
        return obj
    }
    
    public class func removeObjectForKey(key:String)
    {
        defaults.removeObjectForKey(key)
    }
    
    public class func setObject(obj:AnyObject?,ofClass classe:AnyClass,withKey key:String)
    {
        if obj == nil || !obj!.isKindOfClass(classe)
        {
            removeObjectForKey(key)
        }
        else
        {
            defaults.setObject(obj!,forKey:key)
        }
        sync()
    }
    
    public class func hasObjectOfClass(classe:AnyClass,withKey key:String) -> Bool
    {
        let obj = defaults.objectForKey(key)
        if obj == nil || !obj!.isKindOfClass(classe)
        {
            return false
        }
        return true
    }
    
    public class func hasObjectWithKey(key:String) -> Bool
    {
        let obj = defaults.objectForKey(key)
        return obj != nil
    }
    
    // MARK: Strings
    
    public class func getStringForKey(key:String,defaultValue def:String?) -> String?
    {
        if let obj = defaults.objectForKey(key) as? String
        {
            return obj
        }
        return def
    }
    
    public class func setString(obj:String?,withKey key:String)
    {
        if obj == nil
        {
            removeObjectForKey(key)
        }
        else
        {
            defaults.setObject(obj!,forKey:key)
        }
        sync()
    }
    
    public class func hasStringWithKey(key:String) -> Bool
    {
        if let _ = defaults.objectForKey(key) as? String
        {
            return true
        }
        return false
    }
    
    // MARK: Setters
    
    public class func setNumber(n:NSNumber?,withKey key:String)
    {
        setObject(n,ofClass:NSNumber.self,withKey:key)
    }
    
    public class func setBool(b:Bool,withKey key:String)
    {
        setNumber(NSNumber(bool:b),withKey:key)
    }
    
    public class func setInteger(i:Int,withKey key:String)
    {
        setNumber(NSNumber(integer:i),withKey:key)
    }
    
    public class func setLong(l:CLong,withKey key:String)
    {
        setNumber(NSNumber(long:l),withKey:key)
    }
    
    public class func setLongLong(l:CLongLong,withKey key:String)
    {
        setNumber(NSNumber(longLong:l),withKey:key)
    }
    
    public class func setDouble(d:Double,withKey key:String)
    {
        setNumber(NSNumber(double:d),withKey:key)
    }
    
    public class func setFloat(f:Float,withKey key:String)
    {
        setNumber(NSNumber(float:f),withKey:key)
    }
    
    public class func setDate(dt:NSDate?,withKey key:String)
    {
        guard let d = dt else { setNumber(nil, withKey: key); return }
        setNumber(NSNumber(double:d.timeIntervalSince1970),withKey:key)
    }
    
    public class func setDictionary(d:NSDictionary?,withKey key:String)
    {
        setObject(d,ofClass:NSDictionary.self,withKey:key)
    }
    
    public class func setArray(ar:Array<AnyObject>?,withKey key:String)
    {
        setObject(ar,ofClass:NSArray.self,withKey:key)
    }
    
    public class func setData(ar:NSData?,withKey key:String)
    {
        setObject(ar,ofClass:NSData.self,withKey:key)
    }
    
    public class func hasArrayWithKey(key:String) -> Bool
    {
        return hasObjectOfClass(NSArray.self,withKey:key)
    }
    
    public class func hasDictionaryWithKey(key:String) -> Bool
    {
        return hasObjectOfClass(NSDictionary.self,withKey:key)
    }
    
    public class func hasNumberWithKey(key:String) -> Bool
    {
        return hasObjectOfClass(NSNumber.self,withKey:key)
    }
    
    // MARK: Getters
    
    public class func getBoolForKey(key:String,defaultValue def:Bool) -> Bool
    {
        return getNumberForKey(key,defaultValue:nil)?.boolValue ?? def
    }
    
    public class func getIntegerForKey(key:String,defaultValue def:Int) -> Int
    {
        return getNumberForKey(key,defaultValue:nil)?.integerValue ?? def
    }
    
    public class func getLongForKey(key:String,defaultValue def:CLong) -> CLong
    {
        return getNumberForKey(key,defaultValue:nil)?.longValue ?? def
    }
    
    public class func getLongLongForKey(key:String,defaultValue def:CLongLong) -> CLongLong
    {
        return getNumberForKey(key,defaultValue:nil)?.longLongValue ?? def
    }
    
    public class func getDoubleForKey(key:String,defaultValue def:Double) -> Double
    {
        return getNumberForKey(key,defaultValue:nil)?.doubleValue ?? def
    }
    
    public class func getFloatForKey(key:String,defaultValue def:Float) -> Float
    {
        return getNumberForKey(key,defaultValue:nil)?.floatValue ?? def
    }
    
    public class func getDateForKey(key:String,defaultValue def:NSDate?) -> NSDate?
    {
        if let n = getNumberForKey(key,defaultValue:nil) { return NSDate(timeIntervalSince1970:n.doubleValue) }
        return def
    }
    
    public class func getDictionaryForKey(key:String,defaultValue def:NSDictionary?) -> NSDictionary?
    {
        return getObjectOfClass(NSDictionary.self,forKey:key,defaultValue:def) as? NSDictionary ?? def
    }
    
    public class func getArrayForKey(key:String,defaultValue def:Array<AnyObject>?) -> Array<AnyObject>?
    {
        return getObjectOfClass(NSArray.self,forKey:key,defaultValue:def) as? Array<AnyObject> ?? def
    }
    
    public class func getDataForKey(key:String,defaultValue def:NSData?) -> NSData?
    {
        return getObjectOfClass(NSData.self,forKey:key,defaultValue:def) as? NSData ?? def
    }
    
    public class func getNumberForKey(key:String,defaultValue def:NSNumber?) -> NSNumber?
    {
        return getObjectOfClass(NSNumber.self,forKey:key,defaultValue:def) as? NSNumber ?? def
    }
}
