
import Foundation
import UIKit

protocol IDKList : NSObjectProtocol
{
    func values() -> [AnyObject]?
}

public extension UIColor
{
    var colorSpaceModel : CGColorSpaceModel
    {
        return CGColorSpaceGetModel(CGColorGetColorSpace(CGColor));
    }
    
    var canProvideRGBComponents : Bool
    {
        let csm = colorSpaceModel
        return csm == .RGB || csm == .Monochrome
    }
    
    func rgbComponent(index:Int) -> CGFloat
    {
        if !canProvideRGBComponents
        {
            DavKit.log("UIColor","Must be a rgb color to get RGB components")
            return 0
        }
        let c = CGColorGetComponents(CGColor);
        if colorSpaceModel == .Monochrome { return c[0] }
        return c[index]
    }
    
    var red : CGFloat
    {
        return rgbComponent(0)
    }
    
    var green : CGFloat
    {
        return rgbComponent(1)
    }
    
    var blue : CGFloat
    {
        return rgbComponent(2)
    }
    
    var alpha : CGFloat
    {
        return CGColorGetAlpha(CGColor)
    }
}

public extension DKParser
{
    class func colorFromHexString(s:String) -> UIColor?
    {
        var rgbValue : UInt32 = 0;
        let scanner = NSScanner(string: s)
        if s.hasPrefix("#")
        {
            scanner.scanLocation = 1
        }
        scanner.scanHexInt(&rgbValue)
        
        let hex = Int(rgbValue)
        
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 1
        
        if s.characters.count == 8 || s.characters.count == 9
        {
            let div : CGFloat = 255
            red     = CGFloat((hex & 0xFF000000) >> 24) / div
            green   = CGFloat((hex & 0x00FF0000) >> 16) / div
            blue    = CGFloat((hex & 0x0000FF00) >>  8) / div
            alpha   = CGFloat( hex & 0x000000FF       ) / div
        }
        else
        {
            red = CGFloat((hex >> 16) & 0xff)
            green = CGFloat((hex >> 8) & 0xff)
            blue = CGFloat(hex & 0xff)
        }
        
        return UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    class func colorFromRgbString(string:String) -> UIColor?
    {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 1.0
        if let rs = string.rangeOfString("(")
        {
            if let ls = string.rangeOfString(")")
            {
                func floatFromComponent(s:String) -> CGFloat
                {
                    if let i = Float(s)
                    {
                        return CGFloat(i)
                    }
                    return 0.0
                }
                
                let sub = string.substringToIndex(ls.startIndex).substringFromIndex(rs.startIndex.advancedBy(1))
                let comps = sub.componentsSeparatedByString(",")
                if comps.count == 4
                {
                    r = floatFromComponent(comps[0]) / 255.0
                    g = floatFromComponent(comps[1]) / 255.0
                    b = floatFromComponent(comps[2]) / 255.0
                    a = floatFromComponent(comps[3])
                }
                else if comps.count == 3
                {
                    r = floatFromComponent(comps[0]) / 255.0
                    g = floatFromComponent(comps[1]) / 255.0
                    b = floatFromComponent(comps[2]) / 255.0
                }
            }
        }
        return UIColor(red:r,green:g,blue:b,alpha:a)
    }
    
    class func colorFromString(s:String) -> UIColor?
    {
        if s.hasPrefix("rgb")
        {
            return colorFromRgbString(s)
        }
        else if s == "transparent"
        {
            return UIColor.clearColor()
        }
        else
        {
            return colorFromHexString(s)
        }
    }
    
    class func colorToHexRGBA(u:UIColor) -> String
    {
        let r = u.red
        let g = u.green
        let b = u.blue
        let a = u.alpha
        let ri = Int(r*255)
        let gi = Int(g*255)
        let bi = Int(b*255)
        let ai = Int(a*255)
        return String(format:"#%02x%02x%02x%02x",ri,gi,bi,ai)
    }
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
    
    public class func getArray(d:NSDictionary?,forKey key:String, fallback:Array<AnyObject>?) -> Array<AnyObject>?
    {
        return getObject(d,ofClass:NSArray.self,forKey:key,fallback:fallback) as? Array<AnyObject>
    }
    
    public class func getDictionary(d:NSDictionary?,forKey key:String, fallback:[NSObject:AnyObject]?) -> [NSObject:AnyObject]?
    {
        return getObject(d,ofClass:NSDictionary.self,forKey:key,fallback:fallback) as? [NSObject:AnyObject]
    }
    
    public class func getDict(d:NSDictionary?,forKey key:String, fallback:NSDictionary?) -> NSDictionary?
    {
        return getObject(d,ofClass:NSDictionary.self,forKey:key,fallback:fallback) as? NSDictionary
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
    
    public class func getCGFloat(d:NSDictionary?,forKey key:String, fallback:CGFloat) -> CGFloat
    {
        return CGFloat(getSafeNumber(d, forKey: key, fallback:fallback).floatValue)
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
    
    public class func getCGFloat(d:NSDictionary?,forKeys keys:Array<String>, fallback:CGFloat) -> CGFloat
    {
        return CGFloat(getSafeNumber(d, forKeys: keys, fallback:fallback).floatValue)
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
    
    public class func getString(d:NSDictionary?,forKey key:String, fallback:String?) -> String?
    {
        if let od = d
        {
            if let obj = od.objectForKey(key) as? String
            {
                return obj
            }
        }
        return fallback
    }
    
    public class func getString(d:NSDictionary?,forKeys keys:Array<String>, fallback:String?) -> String?
    {
        for key in keys
        {
            if let obj = getString(d,forKey:key,fallback:nil) { return obj }
        }
        return fallback
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
    
    public class func getList(d:NSDictionary?,forKey key:String, fallback:Array<AnyObject>?) -> Array<AnyObject>?
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
    
    public class func getStringList(d:NSDictionary?,forKey key:String, fallback:Array<String>?) -> Array<String>?
    {
        if let ar = getList(d,forKey:key,fallback:nil) as? Array<String>
        {
            return ar
        }
        return fallback
    }
    
    public class func getColor(d:NSDictionary?,forKey key:String,fallback:UIColor?) -> UIColor?
    {
        if let s = d?.objectForKey(key) as? String
        {
            return colorFromString(s)
        }
        if let u = d?.objectForKey(key) as? UIColor
        {
            return u
        }
        return fallback
    }
    
    public class func getColor(d:NSDictionary?,forKeys keys:Array<String>,fallback:UIColor?) -> UIColor?
    {
        for key in keys
        {
            if let obj = getColor(d,forKey:key,fallback:nil) { return obj }
        }
        return fallback
    }
    
    public class func getPoint(d:NSDictionary?,forKey key:String, fallback:CGPoint) -> CGPoint
    {
        return getPoint(d,forKeys:[key],fallback:fallback)
    }
    
    public class func getPoint(d:NSDictionary?,forKeys keys:Array<String>, fallback:CGPoint) -> CGPoint
    {
        var p = fallback
        for key in keys
        {
            let obj = d?.objectForKey(key)
            if obj is String
            {
                let s = obj as! String
                if s.hasPrefix("{")
                {
                    let jd = s.fromJson
                    if jd == nil
                    {
                        p = CGPointFromString(s);
                    }
                    else
                    {
                        p.x = getCGFloat(jd,forKeys:["x","a"],fallback:p.x)
                        p.y = getCGFloat(jd,forKeys:["y","b"],fallback:p.y)
                    }
                }
                else
                {
                    p = CGPointFromString(s);
                }
            }
            else if obj is NSNumber
            {
                let n = obj as! NSNumber
                if key == "x" || key == "a"
                {
                    p.x = CGFloat(n.floatValue)
                }
                else if key == "y" || key == "b"
                {
                    p.y = CGFloat(n.floatValue)
                }
            }
            else if obj is NSValue
            {
                let v = obj as! NSValue
                p = v.CGPointValue()
            }
        }
        return p;
    }
    
    public class func getDateId(d:NSDictionary?,forKey key:String, fallback:DKDateId?) -> DKDateId?
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
    
    public class func setColor(val:UIColor?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:UIColor?=nil,convert:Bool=true)
    {
        func convert(clr:UIColor) -> String
        {
            return colorToHexRGBA(clr)
        }
        
        if let v = val
        {
            setObject(convert(v), forKey:key, inDict:dict, replacement:nil)
        }
        else if let r = replacement
        {
            setObject(convert(r), forKey:key, inDict:dict, replacement:nil)
        }
        else
        {
            setObject(nil, forKey:key, inDict:dict, replacement:nil)
        }
    }
    
    public class func setPoint(val:CGPoint,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        let point = NSStringFromCGPoint(val)
        setObject(point,forKey:key,inDict:dict,replacement:nil)
    }
    
    public class func setDateId(val:DKDateId?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setString(val?.value,forKey:key,inDict:dict)
    }
}

extension DKParser
{
    public class func fromJSONToDictionary(json:String?) -> [String:NSObject]?
    {
        return json?.fromJson
    }
}
