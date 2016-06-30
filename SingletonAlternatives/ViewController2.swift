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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(state: DeviceState) {
        print("ViewController2 received DeviceState: \(state)")
    }
    
    func didUpdateServiceState(state: ServiceState) {
        print("ViewController2 received ServiceState: \(state)")
    }
    
    func didUpdateData(data: ExampleData) {
        print("ViewController2 received data: \(data.timeStamp) -  \(data.value)")
    }
}
