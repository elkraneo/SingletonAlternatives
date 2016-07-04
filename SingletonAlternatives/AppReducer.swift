//
//  AppReducer.swift
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
            deviceState: deviceStateReducer(action: action, state: state?.deviceState),
            serviceState: serviceStateReducer(action: action, state: state?.serviceState),
            serviceData: dataReducer(action: action, data: state?.serviceData)
        )
    }
}