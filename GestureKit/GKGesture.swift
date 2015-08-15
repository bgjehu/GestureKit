//
//  GKGesture.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

public class GKGesture : NSObject {
    
    private var _name : String = ""
    public var name : String {
        get{
            return _name
        }
    }
    public var notificationName : String {
        get{
            return "GESTURE_KIT_NOTIFICATION_GESTURE_\(name.uppercaseString)"
        }
    }
    public var notification : NSNotification {
        get{
            return NSNotification(name: notificationName, object: nil)
        }
    }
    
    public init(name : String) {
        self._name = name
    }
    
    public func registerNotification(observer : AnyObject, selector : Selector) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: notificationName, object: nil)
    }
    
    public func deregisterNotification(observer : AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: notificationName, object: nil)
    }
    
    public func postNotification(){
        NSNotificationCenter.defaultCenter().postNotification(self.notification)
//        print("Gesture \(name) is picked up. Notification posted!")
    }
}

public class GKGestures {
    
    public static var stringValues : [String] {
        get{
            return ["Up","Down","Left","Right","Push"]
        }
    }
    
    public static var All : [GKGesture] {
        get{
            return GKGestures.stringValues.map({name in GKGesture(name: name)})
        }
    }
    
    public static var Up : GKGesture {
        get{
            return GKGesture(name: "Up")
        }
    }
    public static var Down : GKGesture {
        get{
            return GKGesture(name: "Down")
        }
    }
    public static var Left : GKGesture {
        get{
            return GKGesture(name: "Left")
        }
    }
    public static var Right : GKGesture {
        get{
            return GKGesture(name: "Right")
        }
    }
    public static var Push : GKGesture {
        get{
            return GKGesture(name: "Push")
        }
    }
}

public extension CollectionType where Generator.Element == GKGesture {
    public func registerAllNotifications(observer : AnyObject, selector : Selector) {
        if self.count > 0 {
            for index in startIndex..<endIndex {
                self[index].registerNotification(observer, selector: selector)
            }
        } else {
            print("[GKGesture] Extension Error: Cannot register notifications: no given GKGesture instance")
        }
    }
    public func deregisterAllNotifications(observer : AnyObject) {
        if self.count > 0 {
            for index in startIndex..<endIndex {
                self[index].deregisterNotification(observer)
            }
        } else {
            print("[GKGesture] Extension Error: Cannot deregister notifications: no given GKGesture instance")
        }
    }
}

