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
    
    mutating func update(value value: String, x: Double, y: Double, z:Double) -> ExampleData {
        self.value = value
        self.x = x
        self.y = y
        self.z = z
        
        return self
    }
}

protocol CoreServiceDataDelegate {
    var serviceDataSource: CoreServiceDataSource! { get }
    
    func coreServicedidUpdateData(data: ExampleData)
}


class CoreServiceDataSource: NSObject {
    private var serviceDataDelegate: CoreServiceDataDelegate?
    let motionManager = CMMotionManager()
    
    init(delegate: CoreServiceDataDelegate) {
        super.init()
        
        serviceDataDelegate = delegate
        var data = ExampleData(value: "", x: 0, y: 0, z: 0)
        
        // motionManager.gyroUpdateInterval = 5
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) { (gyroData, error) in
            guard let delegate = self.serviceDataDelegate else { return }
            delegate.coreServicedidUpdateData(data.update(value: gyroData.debugDescription, x: gyroData!.rotationRate.x, y: gyroData!.rotationRate.y, z: gyroData!.rotationRate.z))
        }
    }
}
