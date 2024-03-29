//
//  GKClassifier.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

/*
    
*/
public class GKClassifier: NSObject {

    private var _patterns = [GKPattern]()
    public var patterns : [GKPattern] {
        get{
            return _patterns
        }
    }
    private var _minPeakHeight = [Double]()
    public var minPeakHeight : [Double] {
        get{
            return _minPeakHeight
        }
    }
    private var _minProminence = 0.0
    public var minProminence : Double {
        get{
            return _minProminence
        }
    }
    private var _peakHalfWidth = 0
    public var peakHalfWidth : Int {
        get{
            return _peakHalfWidth
        }
    }
    private var _window = 0
    public var window : Int {
        get{
            return _window
        }
    }
    private var _dataQueue : GKQueue!
    public var dataQueue : GKQueue {
        get{
            return _dataQueue
        }
    }
    
    private var costQueue = [[Double]]()
    
    public var length : Int {
        if patterns.count > 0 {
            return patterns[0].length
        } else {
            print("GKClassifier Error --- Cannot access patterns length, no GKPattern instance initialized")
            return 0
        }
    }
    public var width : Int {
        if patterns.count > 0 {
            return patterns[0].width
        } else {
            print("GKClassifier Error --- Cannot access patterns width, no GKPattern instance initialized")
            return 0
        }
    }
    
    public init(patterns : [GKPattern], minPeakHeight : [Double], minProminence : Double, peakHalfWidth : Int, window : Int) {
        super.init()
        if patterns.count > 0 && window >= 0 && minPeakHeight.count == patterns.count && minProminence < 0 && peakHalfWidth > 0 {
            //  parameters are valid
            if patterns.aligned() {
                //  set properties
                self._patterns = patterns
                self._minPeakHeight = minPeakHeight
                self._minProminence = minProminence
                self._peakHalfWidth = peakHalfWidth
                self._window = window
                //  create new queue
                self._dataQueue = GKQueue(length: self.length, width: self.width)
                //  init costQueue
                for _ in 0..<peakHalfWidth {
                    self.costQueue.append(Array(count: patterns.count, repeatedValue: 0.0))
                }
            } else {
                print("GKClassifier Error: Cannot initialize GKClassifier instance, given GKPattern instances are not aligned")
            }
        } else {
            print("GKClassifier Error: Cannot initialize GKClassifier instance with invalid argument: patterns count = \(patterns.count), window = \(window), minPeakHeight = \(minPeakHeight), minProminence = \(minProminence), peakHalfWidth = \(peakHalfWidth)")
        }
    }
    
    public func classify(rawData : [Double]) {
        let data = GKUtilities.quantize(rawData)
        if let testCase = dataQueue.enque(data) {
            var costs = patterns.map({pattern in GKUtilities.findCost(testCase, rhs: pattern, searchRange: window)})
            
            //  cal delta costs
            var deltaCosts = [Double]()
            for i in 0..<costs.count {
                let delta = costs[i] - costQueue[0][i]
                deltaCosts.append(delta)
                print("gesture \(patterns[i].name), cost:\(costs[i])")
                print("gesture \(patterns[i].name), Δcost:\(deltaCosts[i])")
            }
            //  update queue
            costQueue.removeAtIndex(0)
            costQueue.append(costs)
            
            //  test against threshold
            var indices = [Int]()
            for i in 0..<deltaCosts.count {
                if deltaCosts[i] < minProminence && costs[i] < minPeakHeight[i] {
                    indices.append(i)
                }
            }
            
            var maxDeltaCost = 0.0
            var resultIndex = -1
            for i in indices {
                if minPeakHeight[i] - costs[i] > maxDeltaCost {
                    maxDeltaCost = minPeakHeight[i] - costs[i]
                    resultIndex = i
                }
            }
            if resultIndex >= 0 {
                //  Have result
                let resultGesture = GKGesture(name: patterns[resultIndex].name)
                resultGesture.postNotification()
                print("GKClassifier Log: Posted notification \(resultGesture.notificationName)")
            } else {
                //  No result
            }
        } else {
            print("No testCase: dataQueue is full yet.")
        }
    }
}

public class GKClassifiers {
    public static var UpDownLeftRight : GKClassifier {
        get{
            return GKClassifier(patterns: [GKPatterns.Up,GKPatterns.Down,GKPatterns.Left,GKPatterns.Right], minPeakHeight: [250.0,400.0,250.0,300.0], minProminence: -60.0, peakHalfWidth: 3, window: 5)
        }
    }
}
