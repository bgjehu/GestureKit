//
//  GKAppDelegate.swift
//  GestureKit
//
//  Created by Jieyi Hu on 8/20/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

public protocol GKAppDelegate : UIApplicationDelegate {
    func sharedGKManager() -> GKManager
}
