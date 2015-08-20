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
    
    private var _classifier : GKClassifier!
    public var classifier : GKClassifier {
        get{
            return _classifier
        }
        set{
            _classifier = newValue
        }
    }
    
    private var _recorder : GKRecorder!
    public var recorder : GKRecorder {
        get{
            return _recorder
        }
        set{
            _recorder = newValue
        }
    }
    
    private var _classifying : Bool = false
    public var classifying : Bool {
        get{
            return _classifying
        }
        set{
            if newValue == _classifying {
                //  No change
            } else {
                if newValue {
                    //  Try to start classifying
                    if _classifier == nil {
                        //  Cannot start
                        print("GKManager Error: Cannot start classifying when classifier is nil")
                    } else {
                        //  Start successfully
                        _classifying = true
                        recording = false
                    }
                } else {
                    //  Try to stop classifying
                    _classifying = false
                }
            }
        }
    }
    
    private var _recording : Bool = false
    public var recording : Bool {
        get{
            return _recording
        }
        set{
            if newValue == _recording {
                //  No change
            } else {
                if newValue {
                    //  Try to start recording
                    if _recorder == nil {
                        //  Cannot start
                        print("GKManager Error: Cannot start recording when recorder is nil")
                    } else {
                        //  Start successfully
                        _recording = true
                        classifying = false
                    }
                } else {
                    //  Try to stop recording
                    _recording = false
                }
            }
        }

    }
    
    public override init() {
        super.init()
    }
    
    public func handle(data : [Double]) {
        if !classifying && !recording {
            //  Do nothing
        } else {
            if classifying {
                //  should classify
                classifier.classify(data)
            } else {
                //  should record
                recorder.enque(data)
            }
        }
    }
    
    public var handler : ([Double] -> ()) {
        get{
            return handle
        }
    }
    
    public static var sharedManager : GKManager {
        get{
            return (UIApplication.sharedApplication().delegate as! GKAppDelegate).sharedGKManager()
        }
    }
}
