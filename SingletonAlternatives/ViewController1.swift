//
//  ViewController1.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, CorePresenterDelegate {
    
    var presenter: CorePresenter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = CorePresenter(delegate: self)
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(_ state: DeviceState) {
        print("❶ received DeviceState: \(state)")
    }
    
    func didUpdateServiceState(_ state: ServiceState) {
        print("❶ received ServiceState: \(state)")
    }
    
    func didUpdateData(_ data: ExampleData) {
        print("❶ received ExampleData: \(data.timeStamp) -  \(data.value)")
        print("❶ current DeviceState: \(presenter.deviceState)")
        print("❶ current ServiceState: \(presenter.serviceState)")
    }
    
}

