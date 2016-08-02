//: Playground - noun: a place where people can play

import UIKit

var d : NSDictionary = ["number":1,"date":NSDate(),"truth":true]

DKParser.getNumber(d, forKey: "number", fallback:nil)
DKParser.getInteger(d, forKey: "number", fallback:0)
DKParser.getDate(d, forKey: "date", fallback:nil)
DKParser.getDate(d, forKey: "number", fallback:nil)
DKParser.getBool(d, forKey: "truth", fallback: false)
