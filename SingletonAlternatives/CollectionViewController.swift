//
//  CollectionViewController.swift
//  SingletonAlternatives
//
//  Created by Qardio Cristian on 02/07/16.
//  Copyright © 2016 Qardio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, CorePresenterDelegate {
    
    var presenter: CorePresenter!
    
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
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let cell = cell as? CollectionViewCell {
            updateCell(cell, state: presenter.deviceState)
            
            if let data = presenter.serviceData {
                updateCell(cell, data: data)
            }
        }
        
        return cell
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(state: DeviceState) {
        print("\(self) didUpdateDeviceState: \(state)")
        
        updateDebugView(state: state)
    }
    
    func didUpdateServiceState(state: ServiceState) {
        print("\(self) didUpdateServiceState: \(state)")
    }
    
    func didUpdateData(data: ExampleData) {
        updateDebugView(data: data)
    }
    
    //MARK:- Update helpers
    
    func updateDebugView(data data: ExampleData) {
        if let visibleCells = collectionView?.visibleCells() as? [CollectionViewCell] {
            for cell in visibleCells {
                updateCell(cell, data: data)
            }
        }
    }
    
    func updateDebugView(state state: DeviceState) {
        if let visibleCells = collectionView?.visibleCells() as? [CollectionViewCell] {
            for cell in visibleCells {
                updateCell(cell, state: state)
            }
        }
    }
    
    func updateCell(cell: CollectionViewCell, data: ExampleData) {
        cell.debugView.xLabel.text = String(data.x)
        cell.debugView.yLabel.text = String(data.y)
        cell.debugView.zLabel.text = String(data.z)
    }
    
    func updateCell(cell: CollectionViewCell, state: DeviceState) {
        cell.debugView.stateLabel.text = String(state)
    }
    
}
