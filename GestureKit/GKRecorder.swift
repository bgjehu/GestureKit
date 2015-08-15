//
//  GKRecorder.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

public class GKRecorder: NSObject {
    
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
    private var _width = 0
    public var width : Int {
        get{
            return _width
        }
    }
    public init(width : Int) {
        super.init()
        if width > 0 {
            self._width = width
        } else {
            print("GKRecorder Error --- Cannot initialize GKRecorder instance with invalid argument: width = \(width)")
        }
    }
    
    public func enque(data : [Double]) {
        if data.count == width {
            self._data.append(data)
        } else {
            print("GKRecorder Error --- Cannot enque unaligned data point: data point = \(data)")
        }
    }
    
    public func createPattern(name : String) -> GKPattern{
        return GKPattern(name: name, data: self.data)
    }
    
    public func reset(){
        _data.removeAll()
    }
}
