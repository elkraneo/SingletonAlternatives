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

/*
 - http://blog.edenmsg.com/rxswift-migrate-delegates-to-beautiful-observables/
 - https://samritchie.net/2016/05/12/rxswift-delegateproxy-with-required-methods/
 */

class RxCBCentralManagerDelegateProxy: DelegateProxy, CBCentralManagerDelegate, DelegateProxyType {
    let centralManagerSubject = PublishSubject<CBCentralManager>()
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let centralManager: CBCentralManager = object as! CBCentralManager
        return centralManager.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let centralManager: CBCentralManager = object as! CBCentralManager
        centralManager.delegate = delegate as? CBCentralManagerDelegate
    }
    
    internal func centralManagerDidUpdateState(central: CBCentralManager) {
        centralManagerSubject.onNext(central)
        self.forwardToDelegate()?.centralManagerDidUpdateState(central)
    }
    
    deinit {
        centralManagerSubject.onCompleted()
    }
}

extension CBCentralManager {
    public var rx_delegate: DelegateProxy {
        return RxCBCentralManagerDelegateProxy.proxyForObject(self)
    }
    
    public var rx_didUpdateState: Observable<CBCentralManagerState!> {
        let proxy = RxCBCentralManagerDelegateProxy.proxyForObject(self)
        return proxy.centralManagerSubject
            .map { central in
                return central.state
        }
    }
}