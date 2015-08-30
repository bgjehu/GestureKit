//
//  GKManager.swift
//  GestureKit
//
//  Created by Jieyi Hu on 8/15/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

/*
    GKManager utilize GestureKit and WearableKit classes to get data from wearable device to record or classify
*/
public class GKManager: NSObject {
    
    public var classifier : GKClassifier?
    public var recorder : GKRecorder?
    
    private var _classifying : Bool = false {
        didSet{
            if _classifying {
                _recording = false
            }
        }
    }
    public var classifying : Bool {
        get{
            return _classifying
        }
    }
    public func startClassification() {
        _classifying = true
    }
    public func stopClassification() {
        _classifying = false
    }
    
    private var _recording : Bool = false {
        didSet{
            if _recording {
                _classifying = false
            }
        }
    }
    public var recording : Bool {
        get{
            return _recording
        }
    }
    public func startRecording() {
        _recording = true
    }
    public func stopRecording() {
        _recording = false
    }
    
    private override init() {
        super.init()
    }
    
    public func dataHandler(data : [Double]) {
        if !classifying && !recording {
            //  Do nothing
        } else {
            if classifying {
                //  should classify
                classifier?.classify(data)
            } else {
                //  should record
                recorder?.enque(data)
            }
        }
    }
    
    public static var sharedManager = GKManager()
}
