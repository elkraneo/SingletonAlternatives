//
//  RxCBCentralManagerDelegateProxy.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 02/07/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreBluetooth

/// http://blog.edenmsg.com/rxswift-migrate-delegates-to-beautiful-observables/

class RxCBCentralManagerDelegateProxy: DelegateProxy, CBCentralManagerDelegate, DelegateProxyType {
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let centralManager: CBCentralManager = object as! CBCentralManager
        return centralManager.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let centralManager: CBCentralManager = object as! CBCentralManager
        centralManager.delegate = delegate as? CBCentralManagerDelegate
    }
    
    internal func centralManagerDidUpdateState(central: CBCentralManager) {
        interceptedSelector(#selector(CBCentralManagerDelegate.centralManagerDidUpdateState(_:)), withArguments: [central])
    }
}

extension CBCentralManager {
    public var rx_delegate: DelegateProxy {
        return RxCBCentralManagerDelegateProxy.proxyForObject(self)
    }
    
    public var rx_didUpdateState: Observable<CBCentralManagerState!> {
        return rx_delegate.observe(#selector(CBCentralManagerDelegate.centralManagerDidUpdateState(_:)))
            .map { a in
                return (a[0] as? CBCentralManager)?.state
        }
    }
}
