//
//  Presenter.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import RxSwift

protocol CorePresenterDelegate {
    var presenter: CorePresenter! { get }
    
    func didUpdateServiceState(state: ServiceState)
    func didUpdateDeviceState(state: DeviceState)
    func didUpdateData(data: ExampleData)
}


class CorePresenter {
    
    private let disposeBag = DisposeBag()
    private var delegate: CorePresenterDelegate
    private var service: CoreService
    private var serviceDataSource: CoreServiceDataSource
    
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
        self.service = CoreService()
        self.serviceDataSource = CoreServiceDataSource()
        
        setupObservers()
    }
    
    func setupObservers() {
        self.service.observeCentralManagerState()
            .subscribeNext { (deviceState, serviceState) in
                self.deviceState = deviceState
                self.serviceState = serviceState
            }
            .addDisposableTo(disposeBag)
    }
}


//    //MARK:- CoreServiceDelegate
//
//    func coreService(service: CoreService, didUpdateDeviceState state: DeviceState) {
//        deviceState = state
//    }
//
//    func coreService(service: CoreService, didUpdateServiceState state: ServiceState) {
//        serviceState = state
//    }
//
//    //MARK:- CoreServiceDataDelegate
//
//    func coreServicedidUpdateData(data: ExampleData) {
//        serviceData = data
//    }