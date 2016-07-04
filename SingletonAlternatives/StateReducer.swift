//
//  StateReducer.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 04/07/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import ReSwift

struct AppReducer: Reducer {
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            serviceState: serviceStateReducer(action, state: state?.serviceState),
            deviceState: deviceStateReducer(action, state: state?.deviceState)
        )
    }
}

func serviceStateReducer(action: Action, state: ServiceState?) -> ServiceState {
    let state = state ?? .bluetoothOff
    return state
}

func deviceStateReducer(action: Action, state: DeviceState?) -> DeviceState {
    let state = state ?? .off
    return state
}
