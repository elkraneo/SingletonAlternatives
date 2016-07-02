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
    let timeStamp = NSDate()
    let value: String
}


class CoreServiceDataSource {
    private let motionManager = CMMotionManager()

    func observeData() -> Observable<ExampleData> {
        return Observable.create { observer in
            self.motionManager.gyroUpdateInterval = 5
            self.motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) { (gyroData, error) in
                print("\nData update")
                
                observer.onNext(ExampleData(value: gyroData.debugDescription))
            }
            return NopDisposable.instance
        }
    }
}