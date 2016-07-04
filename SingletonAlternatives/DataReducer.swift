//
//  DataReducer.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 04/07/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import ReSwift

func dataReducer(action action: Action, data: ExampleData?) -> ExampleData {
    var data = data ?? ExampleData(value: "", x: 0, y: 0, z: 0)

    if let action = action as? UpdateDeviceData {
        data = action.data
    }
    
    return data
}