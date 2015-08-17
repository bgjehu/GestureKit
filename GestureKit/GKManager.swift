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
    
    var _classifier : GKClassifier!
    public var classifier : GKClassifier {
        get{
            return _classifier
        }
    }
    
    var _recorder : GKRecorder!
    public var recorder : GKRecorder {
        get{
            return _recorder
        }
    }
    
    var _classifying : Bool = false
    public var classifying : Bool {
        get{
            return _classifying
        }
    }
    
    var _recording : Bool = false
    public var recording : Bool {
        get{
            return _recording
        }
    }
    
    public override init() {
        super.init()
    }
}
