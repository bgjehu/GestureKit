//
//  GKGesture.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

/*
    GKGesture is used to register/deregister/post notification for gesture
*/
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
    }
}

/*
    GKGestures are pre-defined GKGesture instances
*/
public class GKGestures {
    
    public static var All : [GKGesture] {
        get{
            return ["Up","Down","Left","Right","Push"].map({name in GKGesture(name: name)})
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

/*
    extensions for [GKGesture]
*/
public extension CollectionType where Generator.Element == GKGesture {
    
    //  register all notification to one selector
    public func registerAllNotifications(observer : AnyObject, selector : Selector) {
        if self.count > 0 {
            for index in startIndex..<endIndex {
                self[index].registerNotification(observer, selector: selector)
            }
        } else {
            print("[GKGesture] Extension Error: Cannot register notifications: no given GKGesture instance")
        }
    }
    
    //  deregister all notification for one observer
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

