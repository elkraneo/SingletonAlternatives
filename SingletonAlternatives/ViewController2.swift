//
//  ViewController2.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, CorePresenterDelegate {
    
    var presenter: CorePresenter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = CorePresenter(delegate: self)
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(state: DeviceState) {
        print("❷ received DeviceState: \(state)")
    }
    
    func didUpdateServiceState(state: ServiceState) {
        print("❷ received ServiceState: \(state)")
    }
    
    func didUpdateData(data: ExampleData) {
        print("❷ received ExampleData: \(data.timeStamp) -  \(data.value)")
        print("❷ current DeviceState: \(presenter.deviceState)")
        print("❷ current ServiceState: \(presenter.serviceState)")
    }
    
}
