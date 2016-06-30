//
//  CoreService.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreBluetooth

enum ServiceState {
    case bluetoothOff, unauthorized, needPairing, disconnected, disconnecting, stopped, scanning, waitingForTouch, connecting, connected, pairing, paired, updating, updatingCritical
}

enum DeviceState {
    case off, sleep, charging, standby, skinTest, active, worn, unknown
}

protocol CoreServiceDelegate {
    var service: CoreService! { get }
    
    func coreService(service: CoreService, didUpdateServiceState state: ServiceState)
    func coreService(service: CoreService, didUpdateDeviceState state: DeviceState)
}


class CoreService: NSObject, CBCentralManagerDelegate {
    private var serviceDelegate: CoreServiceDelegate?
    private var centralManager: CBCentralManager?
    
    init(delegate: CoreServiceDelegate) {
        super.init()
        
        serviceDelegate = delegate
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    //MARK:- CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(central: CBCentralManager)
    {
        guard let delegate = serviceDelegate else { return }
        
        if (central.state == CBCentralManagerState.PoweredOn)
        {
            delegate.coreService(self, didUpdateDeviceState: .active)
            delegate.coreService(self, didUpdateServiceState: .connected)
        }
        else
        {
            delegate.coreService(self, didUpdateDeviceState: .off)
            delegate.coreService(self, didUpdateServiceState: .disconnected)
        }
    }
}