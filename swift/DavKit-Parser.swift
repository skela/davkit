
import Foundation
import UIKit

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

protocol IDKList : NSObjectProtocol
{
    func values() -> [AnyObject]?
}

public extension UIColor
{
    var colorSpaceModel : CGColorSpaceModel?
    {
        return self.cgColor.colorSpace?.model
    }
    
    var canProvideRGBComponents : Bool
    {
        let csm = colorSpaceModel
        return csm == .rgb || csm == .monochrome
    }
    
    func rgbComponent(_ index:Int) -> CGFloat
    {
        if !canProvideRGBComponents
        {
            DavKit.log("UIColor","Must be a rgb color to get RGB components")
            return 0
        }
        let c = cgColor.components;
        if colorSpaceModel == .monochrome { return c![0] }
        return c![index]
    }
    
    var redComponent : CGFloat
    {
        return rgbComponent(0)
    }
    
    var greenComponent : CGFloat
    {
        return rgbComponent(1)
    }
    
    var blueComponent : CGFloat
    {
        return rgbComponent(2)
    }
    
    var alphaComponent : CGFloat
    {
        return cgColor.alpha
    }
}

public extension DKParser
{
    class func colorFromHexString(_ s:String) -> UIColor?
    {
        var rgbValue : UInt32 = 0;
        let scanner = Scanner(string: s)
        if s.hasPrefix("#")
        {
            scanner.scanLocation = 1
        }
        scanner.scanHexInt32(&rgbValue)
        
        let hex = UInt32(rgbValue)
        
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 1
        
        if s.count == 8 || s.count == 9
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
    
    class func colorFromRgbString(_ string:String) -> UIColor?
    {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 1.0
        if let rs = string.range(of: "(")
        {
            if let ls = string.range(of: ")")
            {
                func floatFromComponent(_ s:String) -> CGFloat
                {
                    if let i = Float(s.trim())
                    {
                        return CGFloat(i)
                    }
                    return 0.0
                }
                
                let sub = String(string[string.index(rs.lowerBound,offsetBy:1)..<ls.lowerBound])                
                let comps = sub.components(separatedBy: ",")
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
    
    class func colorFromString(_ s:String) -> UIColor?
    {
        if s.hasPrefix("rgb")
        {
            return colorFromRgbString(s)
        }
        else if s == "transparent"
        {
            return UIColor.clear
        }
        else
        {
            return colorFromHexString(s)
        }
    }
    
    class func colorToHexRGBA(_ u:UIColor) -> String
    {
        let r = u.redComponent
        let g = u.greenComponent
        let b = u.blueComponent
        let a = u.alphaComponent
        let ri = Int(r*255)
        let gi = Int(g*255)
        let bi = Int(b*255)
        let ai = Int(a*255)
        return String(format:"#%02x%02x%02x%02x",ri,gi,bi,ai)
    }
}

open class DKParser
{
    open class func getSafeNumber(_ d:[AnyHashable:Any]?,forKey key:String, fallback:NSNumber) -> NSNumber
    {
        if let ret = getNumber(d, forKey: key, fallback: fallback)
        {
            return ret
        }
        return fallback
    }
    
    open class func getSafeNumber(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>,fallback:NSNumber) -> NSNumber
    {
        if let ret = getNumber(d, forKeys: keys, fallback: fallback)
        {
            return ret
        }
        return fallback
    }
    
    open class func getValue(_ d:[AnyHashable:Any]?,forKey key:String, fallback:NSValue?) -> NSValue?
    {
        if let obj = d?[key] as? NSValue { return obj }; return fallback
    }
    
    open class func getArray(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Array<AnyObject>?) -> Array<AnyObject>?
    {
        if let obj = d?[key] as? Array<AnyObject> { return obj }; return fallback
    }
    
    open class func getDictionary(_ d:[AnyHashable:Any]?,forKey key:String, fallback:[AnyHashable: Any]?) -> [AnyHashable: Any]?
    {
        if let od = d
        {
            if let obj = od[key] as? [AnyHashable: Any]
            {
                return obj
            }
        }
        return fallback
    }
    
    open class func getNumber(_ d:[AnyHashable:Any]?,forKey key:String, fallback:NSNumber?) -> NSNumber?
    {
        if let obj = d?[key] as? NSNumber { return obj }; return fallback
    }
    
    open class func getInteger(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Int) -> Int
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(value:fallback)).intValue
    }
    
    open class func getBool(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Bool) -> Bool
    {
        return getSafeNumber(d, forKey: key, fallback:fallback as NSNumber).boolValue
    }
    
    open class func getFloat(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Float) -> Float
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(value:fallback)).floatValue
    }
    
    open class func getCGFloat(_ d:[AnyHashable:Any]?,forKey key:String, fallback:CGFloat) -> CGFloat
    {
        return CGFloat(getSafeNumber(d, forKey: key, fallback:NSNumber(value:Float(fallback))).floatValue)
    }
    
    open class func getDouble(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Double) -> Double
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(value:fallback)).doubleValue
    }
    
    open class func getInt(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Int32) -> Int32
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(value: fallback as Int32)).int32Value
    }
    
    open class func getLongLong(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Int64) -> Int64
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(value: fallback as Int64)).int64Value
    }
    
    open class func getUnsignedLongLong(_ d:[AnyHashable:Any]?,forKey key:String, fallback:UInt64) -> UInt64
    {
        return getSafeNumber(d, forKey: key, fallback:NSNumber(value: fallback as UInt64)).uint64Value
    }
    
    open class func getValue(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:NSValue?) -> NSValue?
    {
        for key in keys { if let obj = getValue(d,forKey:key,fallback:nil) { return obj } }; return fallback
    }
    
    open class func getArray(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Array<AnyObject>?) -> Array<AnyObject>?
    {
        for key in keys { if let obj = getArray(d,forKey:key,fallback:nil) { return obj } }; return fallback
    }
    
    open class func getDict(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:[String:Any]?) -> [String:Any]?
    {
        for key in keys { if let obj = getDict(d,forKey:key,fallback:nil) { return obj } }; return fallback
    }
    
    open class func getNumber(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:NSNumber?) -> NSNumber?
    {
        for key in keys { if let obj = getNumber(d,forKey:key,fallback:nil) { return obj } }; return fallback
    }
    
    open class func getInteger(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Int) -> Int
    {
        return getSafeNumber(d, forKeys:keys, fallback:NSNumber(value:fallback)).intValue
    }
    
    open class func getBool(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Bool) -> Bool
    {
        return getSafeNumber(d, forKeys: keys, fallback:fallback as NSNumber).boolValue
    }
    
    open class func getFloat(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Float) -> Float
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(value:fallback)).floatValue
    }
    
    open class func getCGFloat(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:CGFloat) -> CGFloat
    {
        return CGFloat(getSafeNumber(d, forKeys: keys, fallback:NSNumber(value:Float(fallback))).floatValue)
    }
    
    open class func getDouble(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Double) -> Double
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(value:fallback)).doubleValue
    }
    
    open class func getInt(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Int32) -> Int32
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(value: fallback as Int32)).int32Value
    }
    
    open class func getLongLong(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:Int64) -> Int64
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(value: fallback as Int64)).int64Value
    }
    
    open class func getUnsignedLongLong(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:UInt64) -> UInt64
    {
        return getSafeNumber(d, forKeys: keys, fallback:NSNumber(value:fallback as UInt64)).uint64Value
    }
    
    open class func getString(_ d:[AnyHashable:Any]?,forKey key:String, fallback:String?) -> String?
    {
        if let od = d
        {
            if let obj = od[key] as? String
            {
                return obj
            }
        }
        return fallback
    }
    
    open class func getString(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:String?) -> String?
    {
        for key in keys
        {
            if let obj = getString(d,forKey:key,fallback:nil) { return obj }
        }
        return fallback
    }
    
    open class func getDate(_ d:[AnyHashable:Any]?,forKey key:String,fallback:Date?) -> Date?
    {
        if let n = d?[key] as? NSNumber
        {
            return Date(timeIntervalSince1970:n.doubleValue)
        }
        if let date = d?[key] as? Date
        {
            return date
        }
        return fallback
    }
    
    open class func getDate(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>,fallback:Date?) -> Date?
    {
        for key in keys
        {
            if let od = d
            {
                if let n = od[key] as? NSNumber
                {
                    return Date(timeIntervalSince1970:n.doubleValue)
                }
                if let date = od[key] as? Date
                {
                    return date
                }
            }
        }
        return fallback
    }
    
    open class func getDict(_ d:[AnyHashable:Any]?,forKey key:String, fallback:[String:Any]?) -> [String:Any]?
    {
        if let od = d
        {
            if let obj = od[key] as? [String:Any]
            {
                return obj
            }
        }
        return fallback
    }
    
    open class func getColor(_ d:[AnyHashable:Any]?,forKey key:String,fallback:UIColor?) -> UIColor?
    {
        if let s = d?[key] as? String
        {
            return colorFromString(s)
        }
        if let u = d?[key] as? UIColor
        {
            return u
        }
        return fallback
    }
    
    open class func getColor(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>,fallback:UIColor?) -> UIColor?
    {
        for key in keys
        {
            if let obj = getColor(d,forKey:key,fallback:nil) { return obj }
        }
        return fallback
    }
    
    open class func getPoint(_ d:[AnyHashable:Any]?,forKey key:String, fallback:CGPoint) -> CGPoint
    {
        return getPoint(d,forKeys:[key],fallback:fallback)
    }
    
    open class func getPoint(_ d:[AnyHashable:Any]?,forKeys keys:Array<String>, fallback:CGPoint) -> CGPoint
    {
        var p = fallback
        
        guard let d = d else { return p }
        
        for key in keys
        {
            let obj = d[key]
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
                p = v.cgPointValue
            }
        }
        return p;
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
    
    open class func getList(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Array<AnyObject>?) -> Array<AnyObject>?
    {
        if let obj = d?[key] as? IDKList
        {
            return obj.values()
        }
        return getArray(d,forKey:key,fallback:fallback)
    }
    
    open class func getStringList(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Array<String>?) -> Array<String>?
    {
        if let ar = getList(d,forKey:key,fallback:nil) as? Array<String>
        {
            return ar
        }
        return fallback
    }
    
    open class func getNumberList(_ d:[AnyHashable:Any]?,forKey key:String, fallback:Array<NSNumber>?) -> Array<NSNumber>?
    {
        if let ar = getList(d,forKey:key,fallback:nil) as? Array<NSNumber>
        {
            return ar
        }
        return fallback
    }
    
    // MARK: Setters
    
    open class func setObject(_ val:Any?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:Any?)
    {
        if let v = val
        {
            dict?.setObject(v,forKey:key as NSCopying)
        }
        else
        {
            if let fb = replacement
            {
                dict?.setObject(fb,forKey:key as NSCopying)
            }
            else
            {
                dict?.removeObject(forKey: key)
            }
        }
    }
    
    open class func setNumber(_ val:NSNumber?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:NSNumber?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    open class func setString(_ val:String?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:String?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement as AnyObject?)
    }
    
    open class func setDictionary(_ val:[String:Any]?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:[String:Any]?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    open class func setArray(_ val:NSArray?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:NSArray?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    open class func setArray(_ val:Array<Any>?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:Array<Any>?=nil)
    {
        setObject(val, forKey:key, inDict:dict, replacement:replacement)
    }
    
    open class func setInt(_ val:Int32,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(value:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    open class func setInteger(_ val:Int,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(value:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    open class func setBool(_ val:Bool,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(value:val), forKey:key, inDict:dict, replacement:nil)
    }
    
    open class func setDouble(_ val:Double,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(value: val), forKey:key, inDict:dict, replacement:nil)
    }
    
    open class func setFloat(_ val:Float,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(value: val), forKey:key, inDict:dict, replacement:nil)
    }
    
    open class func setUnsignedLongLong(_ val:UInt64,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setObject(NSNumber(value: val), forKey:key, inDict:dict, replacement:nil)
    }
    
    open class func setSelector(_ val:Selector?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        if let s = val
        {
            setObject(NSStringFromSelector(s) as AnyObject?, forKey:key, inDict:dict, replacement:nil)
        }
        else
        {
            setObject(nil, forKey:key, inDict:dict, replacement:nil)
        }
    }
    
    open class func setDate(_ val:Date?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:Date?=nil)
    {
        if let v = val
        {
            setObject(NSNumber(value: v.timeIntervalSince1970 as Double), forKey:key, inDict:dict, replacement:replacement as AnyObject?)
        }
        else
        {
            setObject(val as AnyObject?, forKey:key, inDict:dict, replacement:replacement as AnyObject?)
        }
    }
    
    open class func setColor(_ val:UIColor?,forKey key:String,inDict dict:NSMutableDictionary?,replacement:UIColor?=nil,convert:Bool=true)
    {
        func convertColor(_ clr:UIColor) -> String
        {
            return colorToHexRGBA(clr)
        }
        
        if let v = val
        {
            setString(convertColor(v), forKey:key, inDict:dict, replacement:nil)
        }
        else if let r = replacement
        {
            setString(convertColor(r), forKey:key, inDict:dict, replacement:nil)
        }
        else
        {
            setObject(nil, forKey:key, inDict:dict, replacement:nil)
        }
    }
    
    open class func setPoint(_ val:CGPoint,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        let point = NSStringFromCGPoint(val)
        setObject(point as AnyObject?,forKey:key,inDict:dict,replacement:nil)
    }
    
    open class func setDateId(_ val:DKDateId?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        setString(val?.value,forKey:key,inDict:dict)
    }
    
    open class func setDateId(_ val:Date?,withId id:String?,forKey key:String,inDict dict:NSMutableDictionary?)
    {
        if val == nil || id == nil { setString(nil,forKey:key,inDict:dict) }
        else { setDateId(DKDateId(date:val!,andId:id!),forKey:key,inDict:dict) }
    }
}

public extension Dictionary
{
    func getDate(_ key:Key,fallback:Date?=nil) -> Date?
    {
        let v = self[key]
        if let nd = v as? Double
        {
            return Date(timeIntervalSince1970:nd)
        }
        if let nv = v as? NSNumber
        {
            return Date(timeIntervalSince1970:nv.doubleValue)
        }
        if let dv = v as? Date
        {
            return dv
        }
        return fallback
    }
    
    public func getColor(_ key:String,fallback:UIColor?) -> UIColor?
    {
        return DKParser.getColor(self,forKey:key,fallback:fallback)
    }
    
    public func getPoint(_ key:String,fallback:CGPoint) -> CGPoint
    {
        return DKParser.getPoint(self,forKey:key,fallback:fallback)
    }
}

public extension Dictionary where Key:Comparable,Value:Any
{
    public mutating func setDate(_ val:Date?,forKey key:Key)
    {
        set(val?.timeIntervalSince1970 as? Value,forKey:key)
    }
    
    public mutating func setPoint(_ val:CGPoint,forKey key:Key)
    {
        set(NSStringFromCGPoint(val) as? Value,forKey:key)
    }
    
    public mutating func setColor(_ val:UIColor?,forKey key:Key)
    {
        set(val?.hexRGBA as? Value,forKey:key)
    }
}
