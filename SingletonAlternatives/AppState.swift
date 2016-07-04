//
//  AppState.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 04/07/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var serviceState: ServiceState
    var deviceState: DeviceState
}