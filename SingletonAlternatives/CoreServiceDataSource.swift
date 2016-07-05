//
//  CoreServiceData.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreMotion
import RxSwift

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


class CoreServiceDataSource {
    private let motionManager = CMMotionManager()
    private let time = NSDate()
    
    func observeData() -> Observable<ExampleData> {
        var data = ExampleData(value: "", x: 0, y: 0, z: 0)
        
        return Observable.create { observer in
            // self.motionManager.gyroUpdateInterval = 1
            self.motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) { (gyroData, error) in                
                observer.onNext(data.update(value: gyroData.debugDescription, x: gyroData!.rotationRate.x, y: gyroData!.rotationRate.y, z: gyroData!.rotationRate.z))
            }
            return NopDisposable.instance
        }
    }
}