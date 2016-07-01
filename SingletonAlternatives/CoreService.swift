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
    
    func coreService(_ service: CoreService, didUpdateServiceState state: ServiceState)
    func coreService(_ service: CoreService, didUpdateDeviceState state: DeviceState)
}


class CoreService: NSObject, CBCentralManagerDelegate {
    private var serviceDelegate: CoreServiceDelegate?
    private var centralManager: CBCentralManager?
    
    init(delegate: CoreServiceDelegate) {
        super.init()
        
        serviceDelegate = delegate
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }
    
    //MARK:- CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        guard let delegate = serviceDelegate else { return }
        
        print("\nState update")

        if (central.state == .poweredOn)
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
