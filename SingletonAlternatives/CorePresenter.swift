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
        
        setupObservers()
    }
    
    func setupObservers() {
        service.observeState()
            .subscribeNext { (deviceState, serviceState) in
                self.deviceState = deviceState
                self.serviceState = serviceState
            }
            .addDisposableTo(disposeBag)
        
        serviceDataSource.observeData()
            .subscribeNext { (data) in
                //dont update display if device .off
                guard self.deviceState != .off else { return }
                self.serviceData = data
            }
            .addDisposableTo(disposeBag)
    }

}