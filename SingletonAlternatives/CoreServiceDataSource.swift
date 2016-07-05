//
//  CoreServiceData.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreMotion

struct ExampleData {
    var value: String
    
    var x: Double
    var y: Double
    var z: Double
}

class CoreServiceDataSource: NSObject {
    let motionManager = CMMotionManager()
    
    override init() {
        super.init()
        
        // motionManager.gyroUpdateInterval = 5
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) { (gyroData, error) in
            if let rotationRate = gyroData?.rotationRate {
                mainStore.dispatch(
                    UpdateDeviceData(data: ExampleData(value: gyroData.debugDescription, x: rotationRate.x, y: rotationRate.y, z: rotationRate.z))
                )
            }
        }
    }
}
