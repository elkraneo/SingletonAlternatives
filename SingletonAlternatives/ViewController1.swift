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
        self.presenter = CorePresenter(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(_ state: DeviceState) {
        print("ViewController1 received DeviceState: \(state)")
    }
    
    func didUpdateServiceState(_ state: ServiceState) {
        print("ViewController1 received ServiceState: \(state)")
    }
    
    func didUpdateData(_ data: ExampleData) {
        print("ViewController1 received data: \(data.timeStamp) -  \(data.value)")
    }
    
}

