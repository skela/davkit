//: [Previous](@previous)

import Foundation

public class DKPrefsTestContainer : DKPrefsContainer
{
    var dict = NSMutableDictionary()
    public func synchronize() -> Bool { return true }
    public func objectForKey(key:String) -> AnyObject? { return dict.objectForKey(key) }
    public func removeObjectForKey(key:String) { dict.removeObjectForKey(key) }
    public func setObject(obj:AnyObject?,forKey:String) { dict.setObject(obj!, forKey:forKey) }
}

public class DKPrefsTest : DKPrefs
{
    public static var testing = DKPrefsTestContainer()
    public override class var defaults : DKPrefsContainer
    {
        return testing
    }
    
    public override class func sync() -> Bool
    {
        return true
    }
}

DKPrefsTest.setString("ABC", withKey: "string")
DKPrefsTest.getStringForKey("string", defaultValue:nil)

DKPrefsTest.setInteger(123, withKey: "integer")
DKPrefsTest.getIntegerForKey("integer", defaultValue: 0)

DKPrefsTest.setDate(NSDate(), withKey: "date")
DKPrefsTest.getDateForKey("date", defaultValue: nil)

DKPrefsTest.setLong(12,withKey: "long")
DKPrefsTest.getLongForKey("long", defaultValue: 0)

DKPrefsTest.setArray(["123","456"], withKey: "array")
DKPrefsTest.getArrayForKey("array", defaultValue: nil)

DKPrefsTest.setDictionary(["testing":"yes","no":"maybe"], withKey: "dict")
DKPrefsTest.getDictionaryForKey("dict", defaultValue: nil)

