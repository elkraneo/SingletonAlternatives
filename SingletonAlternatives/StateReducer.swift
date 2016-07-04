//
//  StateReducer.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 04/07/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import ReSwift

func serviceStateReducer(action action: Action, state: ServiceState?) -> ServiceState {
    var state = state ?? .bluetoothOff
    
    if let action = action as? UpdateServiceState {
        state = action.state
    }
    
    return state
}

func deviceStateReducer(action action: Action, state: DeviceState?) -> DeviceState {
    var state = state ?? .off

    if let action = action as? UpdateDeviceState {
        state = action.state
    }
    
    return state
}
