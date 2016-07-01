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
    let timeStamp = Date()
    let value: String
}

protocol CoreServiceDataDelegate {
    var serviceDataSource: CoreServiceDataSource! { get }
    
    func coreServicedidUpdateData(_ data: ExampleData)
}


class CoreServiceDataSource: NSObject {
    private var serviceDataDelegate: CoreServiceDataDelegate?
    let motionManager = CMMotionManager()
    
    init(delegate: CoreServiceDataDelegate) {
        super.init()
        
        serviceDataDelegate = delegate
        
        motionManager.gyroUpdateInterval = 5
        motionManager.startGyroUpdates(to: OperationQueue.current()!) { (gyroData, error) in
            guard let delegate = self.serviceDataDelegate else { return }

            print("\nData update")

            delegate.coreServicedidUpdateData(ExampleData(value: gyroData.debugDescription))
        }
    }
}
