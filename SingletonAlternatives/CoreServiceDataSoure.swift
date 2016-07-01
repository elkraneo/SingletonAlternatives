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
    let timeStamp = Date()
    let value: String
}

protocol CoreServiceDataDelegate {
    var serviceDataSource: CoreServiceDataSource! { get }
    
    func coreServicedidUpdateData(_ data: ExampleData)
}


class CoreServiceDataSource: NSObject, CBCentralManagerDelegate {
    private var serviceDataDelegate: CoreServiceDataDelegate?
    private var centralManager: CBCentralManager?
    
    init(delegate: CoreServiceDataDelegate) {
        super.init()
        
        serviceDataDelegate = delegate
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }
    
    //MARK:- CBCentralManagerDelegate
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : AnyObject], rssi RSSI: NSNumber) {
        
        print(peripheral)
        
        guard let delegate = serviceDataDelegate else { return }
        
        if let peripheralName = peripheral.name {
            delegate.coreServicedidUpdateData(ExampleData(value: peripheralName))
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Another delegate")
    }
}
