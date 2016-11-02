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
    func object(forKey key:String) -> Any?
    func removeObject(forKey key:String)
    func set(_ obj:Any?,forKey key:String)
}

extension UserDefaults : DKPrefsContainer
{
    
}

open class DKPrefs : NSObject
{
    public class func clear()
    {
        
    }
    
    //MARK: Generic
    
    public class var defaults : DKPrefsContainer
    {
        return UserDefaults.standard
    }
    
    @discardableResult
    public class func sync() -> Bool
    {
        return defaults.synchronize()
    }
    
    public class func getObjectOfClass(_ classe:AnyClass,forKey key:String,defaultValue def:AnyObject?) -> AnyObject?
    {
        guard let ao = defaults.object(forKey:key) else { return def }
        
        let obj = ao as AnyObject
        if obj.isKind(of:classe) { return obj }
        
        return def
    }
    
    public class func removeObjectForKey(_ key:String)
    {
        defaults.removeObject(forKey:key)
    }
    
    public class func setObject(_ obj:AnyObject?,ofClass classe:AnyClass,withKey key:String)
    {
        if obj == nil || !obj!.isKind(of:classe)
        {
            removeObjectForKey(key)
        }
        else
        {
            defaults.set(obj!,forKey:key)
        }
        sync()
    }
    
    public class func hasObjectOfClass(_ classe:AnyClass,withKey key:String) -> Bool
    {
        guard let ao = defaults.object(forKey:key) else { return false }
        
        let obj = ao as AnyObject
        if !obj.isKind(of:classe)
        {
            return false
        }
        
        return true
    }
    
    public class func hasObject(withKey key:String) -> Bool
    {
        let obj = defaults.object(forKey:key)
        return obj != nil
    }
    
    // MARK: Strings
    
    public class func getStringForKey(_ key:String,defaultValue def:String?) -> String?
    {
        if let obj = defaults.object(forKey:key) as? String
        {
            return obj
        }
        return def
    }
    
    public class func setString(_ obj:String?,withKey key:String)
    {
        if obj == nil
        {
            removeObjectForKey(key)
        }
        else
        {
            defaults.set(obj!,forKey:key)
        }
        sync()
    }
    
    public class func hasString(withKey key:String) -> Bool
    {
        if let _ = defaults.object(forKey:key) as? String
        {
            return true
        }
        return false
    }
    
    // MARK: Data
    
    public class func getData(forKey key:String,default def:Data?) -> Data?
    {
        if let obj = defaults.object(forKey:key) as? Data
        {
            return obj
        }
        return def
    }
    
    public class func setData(_ obj:Data?,withKey key:String)
    {
        if obj == nil
        {
            removeObjectForKey(key)
        }
        else
        {
            defaults.set(obj!,forKey:key)
        }
        sync()
    }
    
    // MARK: Setters
    
    public class func setNumber(_ n:NSNumber?,withKey key:String)
    {
        setObject(n,ofClass:NSNumber.self,withKey:key)
    }
    
    public class func setBool(_ b:Bool,withKey key:String)
    {
        setNumber(NSNumber(value:b),withKey:key)
    }
    
    public class func setInteger(_ i:Int,withKey key:String)
    {
        setNumber(NSNumber(value:i),withKey:key)
    }
    
    public class func setLong(_ l:CLong,withKey key:String)
    {
        setNumber(NSNumber(value:l),withKey:key)
    }
    
    public class func setLongLong(_ l:CLongLong,withKey key:String)
    {
        setNumber(NSNumber(value:l),withKey:key)
    }
    
    public class func setDouble(_ d:Double,withKey key:String)
    {
        setNumber(NSNumber(value:d),withKey:key)
    }
    
    public class func setFloat(_ f:Float,withKey key:String)
    {
        setNumber(NSNumber(value:f),withKey:key)
    }
    
    public class func setDate(_ dt:Date?,withKey key:String)
    {
        guard let d = dt else { setNumber(nil, withKey: key); return }
        setNumber(NSNumber(value:d.timeIntervalSince1970),withKey:key)
    }
    
    public class func setDictionary(_ d:NSDictionary?,withKey key:String)
    {
        setObject(d,ofClass:NSDictionary.self,withKey:key)
    }
    
    public class func hasArrayWithKey(_ key:String) -> Bool
    {
        return hasObjectOfClass(NSArray.self,withKey:key)
    }
    
    public class func setArray(_ obj:Array<Any>?,withKey key:String)
    {
        if obj == nil
        {
            removeObjectForKey(key)
        }
        else
        {
            defaults.set(obj!,forKey:key)
        }
        sync()
    }
    
    public class func hasDictionaryWithKey(_ key:String) -> Bool
    {
        return hasObjectOfClass(NSDictionary.self,withKey:key)
    }
    
    public class func hasNumberWithKey(_ key:String) -> Bool
    {
        return hasObjectOfClass(NSNumber.self,withKey:key)
    }
    
    // MARK: Getters
    
    public class func getBoolForKey(_ key:String,defaultValue def:Bool) -> Bool
    {
        return getNumberForKey(key,defaultValue:nil)?.boolValue ?? def
    }
    
    public class func getIntegerForKey(_ key:String,defaultValue def:Int) -> Int
    {
        return getNumberForKey(key,defaultValue:nil)?.intValue ?? def
    }
    
    public class func getLongForKey(_ key:String,defaultValue def:CLong) -> CLong
    {
        return getNumberForKey(key,defaultValue:nil)?.intValue ?? def
    }
    
    public class func getLongLongForKey(_ key:String,defaultValue def:CLongLong) -> CLongLong
    {
        return getNumberForKey(key,defaultValue:nil)?.int64Value ?? def
    }
    
    public class func getDoubleForKey(_ key:String,defaultValue def:Double) -> Double
    {
        return getNumberForKey(key,defaultValue:nil)?.doubleValue ?? def
    }
    
    public class func getFloatForKey(_ key:String,defaultValue def:Float) -> Float
    {
        return getNumberForKey(key,defaultValue:nil)?.floatValue ?? def
    }
    
    public class func getDateForKey(_ key:String,defaultValue def:Date?) -> Date?
    {
        if let n = getNumberForKey(key,defaultValue:nil) { return Date(timeIntervalSince1970:n.doubleValue) }
        return def
    }
    
    public class func getDictionaryForKey(_ key:String,defaultValue def:NSDictionary?) -> NSDictionary?
    {
        return getObjectOfClass(NSDictionary.self,forKey:key,defaultValue:def) as? NSDictionary ?? def
    }
    
    public class func getArrayForKey(_ key:String,defaultValue def:NSArray?) -> NSArray?
    {
        return getObjectOfClass(NSArray.self,forKey:key,defaultValue:def) as? NSArray ?? def
    }
        
    public class func getNumberForKey(_ key:String,defaultValue def:NSNumber?) -> NSNumber?
    {
        return getObjectOfClass(NSNumber.self,forKey:key,defaultValue:def) as? NSNumber ?? def
    }
}
