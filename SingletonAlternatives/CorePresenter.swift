//
//  Presenter.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import ReSwift

protocol CorePresenterDelegate {
    var presenter: CorePresenter! { get }
    
    func didUpdateServiceState(state: ServiceState)
    func didUpdateDeviceState(state: DeviceState)
    func didUpdateData(data: ExampleData)
}

class CorePresenter: StoreSubscriber {
    
    private var delegate: CorePresenterDelegate!
    var service: CoreService!
    var serviceDataSource: CoreServiceDataSource!
    
    private(set) var deviceState = DeviceState.off {
        didSet {
            delegate.didUpdateDeviceState(deviceState)
        }
    }
    
    private(set) var serviceState = ServiceState.bluetoothOff {
        didSet {
            delegate.didUpdateServiceState(serviceState)
        }
    }
    
    private(set) var serviceData: ExampleData? {
        didSet {
            delegate.didUpdateData(serviceData!)
        }
    }
    
    
    init(delegate: CorePresenterDelegate) {
        self.delegate = delegate
        self.service = CoreService()
        self.serviceDataSource = CoreServiceDataSource()
        
        mainStore.subscribe(self)
    }
    
    deinit {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        deviceState = state.deviceState
        serviceState = state.serviceState
        
        //dont update display if device .off
        guard deviceState != .off else { return }
        serviceData = state.serviceData
    }
}
