//
//  ViewController1.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CorePresenterDelegate {
    
    var presenter: CorePresenter!
    @IBOutlet var debugView: DebugView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.presenter = CorePresenter(delegate: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateDebugView(state: presenter.deviceState)
        if let data = presenter.serviceData {
            updateDebugView(data: data)
        }
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(state: DeviceState) {
        print("\(self) didUpdateDeviceState: \(state)")
        
        guard (debugView != nil) else { return }
        updateDebugView(state: state)
    }
    
    func didUpdateServiceState(state: ServiceState) {
        print("\(self) didUpdateServiceState: \(state)")
    }
    
    func didUpdateData(data: ExampleData) {
        //print("\(self) didUpdateData: \(data)")
        //print("\(self) current DeviceState: \(presenter.deviceState)")
        //print("\(self) current ServiceState: \(presenter.serviceState)")
        
        guard (debugView != nil) else { return }
        updateDebugView(data: data)
    }
    
    //MARK:- Update helpers
    
    func updateDebugView(state state: DeviceState) {
        debugView.stateLabel.text = String(state)
    }
    
    func updateDebugView(data data: ExampleData) {
        debugView.xLabel.text = String(data.x)
        debugView.yLabel.text = String(data.y)
        debugView.zLabel.text = String(data.z)
    }
    
}

