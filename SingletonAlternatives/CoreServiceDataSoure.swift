//
//  CoreServiceData.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 30/06/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import Foundation
import CoreBluetooth

struct ExampleData {
    let timeStamp = NSDate()
    let value: String
}

protocol CoreServiceDataDelegate {
    var serviceDataSource: CoreServiceDataSource! { get }
    
    func coreServicedidUpdateData(data: ExampleData)
}


class CoreServiceDataSource: NSObject, CBCentralManagerDelegate {
    private var serviceDataDelegate: CoreServiceDataDelegate?
    private var centralManager: CBCentralManager?
    
    init(delegate: CoreServiceDataDelegate) {
        super.init()
        
        serviceDataDelegate = delegate
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    //MARK:- CBCentralManagerDelegate
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        print(peripheral)
        
        guard let delegate = serviceDataDelegate else { return }
        
        if let peripheralName = peripheral.name {
            delegate.coreServicedidUpdateData(ExampleData(value: peripheralName))
        }
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("Another delegate")
    }
}