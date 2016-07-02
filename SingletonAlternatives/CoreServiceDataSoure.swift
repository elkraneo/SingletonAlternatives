//
//  CoreServiceData.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift
import RxCocoa

struct ExampleData {
    let timeStamp = NSDate()
    let value: String
}

/// http://blog.edenmsg.com/rxswift-migrate-delegates-to-beautiful-observables/

//class RxCBCentralManagerDelegateProxy: DelegateProxy, CBCentralManagerDelegate, DelegateProxyType {
//    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
//        let locationManager: CBCentralManager = object as! CBCentralManager
//        return locationManager.delegate
//    }
//    
//    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
//        let locationManager: CBCentralManager = object as! CBCentralManager
//        locationManager.delegate = delegate as? CBCentralManagerDelegate
//    }
//    
//    internal func centralManagerDidUpdateState(central: CBCentralManager) {
//        interceptedSelector(#selector(CBCentralManagerDelegate.centralManagerDidUpdateState(_:)), withArguments: [central])
//    }
//}
//
//extension CBCentralManager {
//    public var rx_delegate: DelegateProxy {
//        return RxCBCentralManagerDelegateProxy.proxyForObject(self)
//    }
//    
//    public var rx_didUpdateState: Observable<CBCentralManagerState!> {
//        return rx_delegate.observe(#selector(CBCentralManagerDelegate.centralManagerDidUpdateState(_:)))
//            .map { a in
//                return (a[0] as? CBCentralManager)?.state
//        }
//    }
//}

class CoreServiceDataSource {
//    private var centralManager: CBCentralManager
    private let disposeBag = DisposeBag()
    
    init() {
//        centralManager = CBCentralManager()
//        centralManager.rx_didUpdateState
//            .subscribeNext { (state) in
//                print(state)
//            }
//            .addDisposableTo(disposeBag)
    }
}