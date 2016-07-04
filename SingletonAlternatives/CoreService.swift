//
//  CoreService.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreBluetooth
import ReSwift

enum ServiceState {
    case bluetoothOff, unauthorized, needPairing, disconnected, disconnecting, stopped, scanning, waitingForTouch, connecting, connected, pairing, paired, updating, updatingCritical
}

enum DeviceState {
    case off, sleep, charging, standby, skinTest, active, worn, unknown
}

class CoreService: NSObject, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    //MARK:- CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(central: CBCentralManager)
    {
        print("\nState update")
        
        if (central.state == .PoweredOn)
        {
            store.dispatch(UpdateDeviceState(state: .active))
            store.dispatch(UpdateServiceState(state: .connected))
        }
        else
        {
            store.dispatch(UpdateDeviceState(state: .off))
            store.dispatch(UpdateServiceState(state: .disconnected))
        }
    }
}
