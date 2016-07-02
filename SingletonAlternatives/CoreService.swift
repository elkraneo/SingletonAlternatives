//
//  CoreService.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift

enum ServiceState {
    case bluetoothOff, unauthorized, needPairing, disconnected, disconnecting, stopped, scanning, waitingForTouch, connecting, connected, pairing, paired, updating, updatingCritical
}

enum DeviceState {
    case off, sleep, charging, standby, skinTest, active, worn, unknown
}


class CoreService {
    private let centralManager = CBCentralManager()
    
    func observeState() -> Observable<(DeviceState, ServiceState)> {
        return centralManager.rx_didUpdateState
            .map({ state -> (DeviceState, ServiceState) in
                print("\nState update")

                switch state as CBCentralManagerState {
                case .PoweredOn:
                    return (.active, .connected)
                    
                default:
                    return (.off, .disconnected)
                }
            })
    }
}