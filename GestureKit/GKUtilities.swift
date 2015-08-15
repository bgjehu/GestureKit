//
//  GKUtilities.swift
//  BSSDemo
//
//  Created by Jieyi Hu on 8/6/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

import UIKit

public class GKUtilities: NSObject {
    
    public static func findCost(lhs : GKPattern, rhs : GKPattern, searchRange : Int) -> Double {
        if lhs.isAlignedWith(rhs) {
            let length = lhs.length
            
//            let startTime = NSDate()
            //  Create cost table
            var costTable = GKUtilities.initCostTable(length)

            //  Fill cost table
            for i in 1...length {
                for j in max(1,i - searchRange)...min(length,i + searchRange) {
                    costTable[i][j] = GKUtilities.findDistance(lhs, rhs: rhs, lhsIndex: i-1, rhsIndex: i-1) + [costTable[i][j-1],costTable[i-1][j],costTable[i-1][j-1]].reduce(DBL_MAX, combine: {min($0, $1)})
                }
            }
            
            //  Calculate Cost
            var minDist = 0
            var finalMin = costTable[length][length]
            for index in 1...searchRange {
                let newMin = min(costTable[length][length - index], costTable[length - index][length])
                if  newMin < finalMin {
                    minDist = index
                    finalMin = newMin
                }
            }
//            print("Cal Cost Time: \(startTime.timeIntervalSinceNow * -1)")
            return finalMin + Double(minDist * 10)
        } else {
            print("GKUtilities Error: Cannot find cost of GKPattern instances, GKPattern instances do not align")
            return DBL_MAX
        }
    }
    
    public static func findDistance(lhs : GKPattern, rhs : GKPattern, lhsIndex : Int, rhsIndex : Int) -> Double {
        if lhsIndex < lhs.length && rhsIndex < rhs.length {
            if lhs.isAlignedWith(rhs) {
//                let startTime = NSDate()
                var dist = 0.0
                for i in 0..<lhs.width {
                    dist += pow(Double(lhs.data[lhsIndex][i] - rhs.data[rhsIndex][i]), 2)
                }
                dist = sqrt(dist)
//                print("Cal Dist Time: \(startTime.timeIntervalSinceNow * -1)")
                return dist
            } else {
                print("GKUtilities Error: Cannot find distance for data points from GKPattern instances, GKPattern instances do not align")
                return 0
            }
        } else {
            print("GKUtilities Error: Cannot find distance for data points from GKPattern instances with invalid indices, (lhsIndex, rhsIndex) = (\(lhsIndex), \(rhsIndex))")
            return 0
        }
    }
    
    public static func initCostTable(length : Int) -> [[Double]] {
        var costTable = [[Double]]()
        let tableLength = length + 1
        for _ in 0..<tableLength {
            costTable.append(Array(count: tableLength, repeatedValue: DBL_MAX))
        }
        costTable[0][0] = 0
        return costTable
    }
    
    public static func quantize(data : [Double]) -> [Double] {
        return data.map({num in round(num / 0.1)})
    }

}


