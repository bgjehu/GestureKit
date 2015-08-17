//
//  GKQueue.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

/*
    GKQueue is used to store incoming physical data
    Use enque() to store new data
*/
public class GKQueue: NSObject {
    
    private var _data = [[Double]]()
    public var data : [[Double]] {
        get{
            return _data
        }
    }
    private var _length = 0
    public var length : Int {
        get{
            return _length
        }
    }
    private var _width = 0
    public var width : Int {
        get{
            return _width
        }
    }
    private var _full = false
    public var full : Bool {
        get{
            return _full
        }
    }
    
    public init(length : Int, width : Int) {
        super.init()
        if length > 0 && width > 0{
            self._length = length
            self._width = width
        } else {
            print("GKQueue Error --- Cannot initialize GKQueue instance with invalid argument: (length,width) = (\(length),\(width))")
        }
    }
    
    public func enque(data : [Double]) -> GKPattern? {
        if data.count == width {
            if full {
                self._data.removeAtIndex(0)
            } else {
                //  Do nothing
            }
            self._data.append(data)
            if self.data.count == length {
                _full = true
                return GKPattern(data: self.data)
            } else if self.data.count > length {
                print("GKQueue Error --- GKQueue instance is overloaded with \(self.data.count - length) data instances")
                return nil
            } else {
                return nil
            }
        } else {
            print("GKQueue Error --- Cannot enque unaligned data point: data point = \(data)")
            return nil
        }
    }
}
