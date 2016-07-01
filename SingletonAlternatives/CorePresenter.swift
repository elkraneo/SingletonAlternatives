//
//  Presenter.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation

protocol CorePresenterDelegate {
    var presenter: CorePresenter! { get }
    
    func didUpdateServiceState(_ state: ServiceState)
    func didUpdateDeviceState(_ state: DeviceState)
    func didUpdateData(_ data: ExampleData)
}


class CorePresenter: CoreServiceDelegate, CoreServiceDataDelegate {
    
    private var delegate: CorePresenterDelegate!
    var service: CoreService!
    var serviceDataSource: CoreServiceDataSource!
    
    var deviceState = DeviceState.off {
        didSet {
            delegate.didUpdateDeviceState(deviceState)
        }
    }
    
    var serviceState = ServiceState.bluetoothOff {
        didSet {
            delegate.didUpdateServiceState(serviceState)
        }
    }
    
    var serviceData: ExampleData? {
        didSet {
            delegate.didUpdateData(serviceData!)
        }
    }
    
    
    init(delegate: CorePresenterDelegate) {
        self.delegate = delegate
        self.service = CoreService(delegate: self)
        self.serviceDataSource = CoreServiceDataSource(delegate: self)
    }
    
    //MARK:- CoreServiceDelegate
    
    func coreService(_ service: CoreService, didUpdateDeviceState state: DeviceState) {
        deviceState = state
    }
    
    func coreService(_ service: CoreService, didUpdateServiceState state: ServiceState) {
        serviceState = state
    }
    
    //MARK:- CoreServiceDataDelegate
    
    func coreServicedidUpdateData(_ data: ExampleData) {
        serviceData = data
    }
}
