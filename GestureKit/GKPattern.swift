//
//  GKPattern.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

public class GKPattern: NSObject {
    
    private var _name : String = ""
    public var name : String {
        get{
            return _name
        }
    }
    private var _data = [[Double]]()
    public var data : [[Double]] {
        get{
            return _data
        }
    }
    public var length : Int {
        get{
            return data.count
        }
    }
    public var width : Int {
        get{
            if data.count > 0 {
                return data[0].count
            } else {
                print("GKPattern Error --- Cannot access width property, GKPattern instance is empty")
                return 0
            }
        }
    }
    
    public init(data : [[Double]]){
        super.init()
        self._data = data
    }
    
    public init(name : String, data : [[Double]]) {
        self._name = name
        self._data = data
    }
    
    public func isAlignedWith(rhs : GKPattern) -> Bool {
        return self.length == rhs.length && self.width == rhs.width
    }
    
    public func saveLocally() {
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonStr = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
            let fileName = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("\(name).pttn")
            try jsonStr?.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error)
        }
    }
}

public class GKPatterns {
    public static var Up : GKPattern {
        get{
            return GKPattern(name: "Up", data:   [[3,-7,5],[5,-7,5],[5,-6,7],[5,-6,8],[5,-6,9],[4,-7,11],[4,-7,16],[6,-7,22],[11,-8,26],[19,-9,27],[22,-5,23],[21,-3,15],[19,-1,7],[15,-3,1],[11,1,-2],[8,3,-8],[1,2,-11],[-5,4,-13],[-8,3,-10],[-9,2,-3],[-11,-2,3],[-11,-4,6],[-10,-6,5],[-9,-6,5],[-9,-5,6]])
        }
    }
    public static var Down : GKPattern {
        get{
            return GKPattern(name: "Down", data: [[8,-12,6],[15,-14,9],[18,-15,10],[17,-16,0],[18,-19,-12],[18,-19,-8],[18,-14,-5],[17,-10,-9],[14,-6,-10],[10,0,-4],[6,3,1],[3,5,2],[1,4,1],[-1,3,1],[-1,2,2],[0,0,4],[1,-1,4],[2,-1,7],[4,-7,14],[13,-18,14],[23,-15,16],[19,-23,13],[13,-22,-2],[9,-18,-9],[10,-15,-7]])
        }
    }
    public static var Left : GKPattern {
        get{
            return GKPattern(name: "Left", data:  [[2,-6,-9],[2,-6,-9],[3,-6,-10],[3,-5,-9],[3,-4,-9],[3,-2,-8],[4,0,-9],[4,2,-9],[4,5,-9],[5,9,-10],[6,16,-14],[9,19,-13],[13,15,-10],[23,3,-11],[28,-7,-8],[24,-10,-4],[14,-18,0],[7,-14,-1],[7,-8,-3],[3,-11,-2],[0,-10,-3],[0,-6,-6],[-2,-6,-7],[-2,-7,-6],[-2,-7,-6]])
        }
    }
    public static var Right : GKPattern {
        get{
            return GKPattern(name: "Right", data: [[1,-7,-6],[0,-7,-7],[-1,-7,-6],[-1,-7,-4],[-1,-9,-3],[1,-9,0],[1,-10,8],[9,-22,7],[21,-28,0],[21,-13,2],[22,-5,-7],[16,3,-14],[8,-11,-9],[6,12,-8],[9,3,-15],[3,2,-10],[1,1,-7],[-1,-3,-7],[-2,-5,-8],[-2,-6,-8],[-1,-6,-8],[-1,-7,-8],[-1,-7,-8],[-1,-6,-8],[-1,-6,-8]])
        }
    }
}

public extension CollectionType where Generator.Element == GKPattern {
    public func aligned() -> Bool {
        if self.count > 0 {
            for index in startIndex..<endIndex {
                if !self[index].isAlignedWith(self[startIndex]) {
                    return false
                }
                //  checked current pattern
            }
            //  checked all patterns
            return true
        } else {
            print("[GKPattern] Extension Error: Cannot determine alignment of GKPattern instances: no given GKPattern instance")
            return false
        }
    }
}
