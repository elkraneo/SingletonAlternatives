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
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
                
        return cell
    }
    
    //MARK:- CorePresenterDelegate
    
    func didUpdateDeviceState(state: DeviceState) {
        print("\(self) didUpdateDeviceState: \(state)")
        
        updateCells(state: state)
    }
    
    func didUpdateServiceState(state: ServiceState) {
        print("\(self) didUpdateServiceState: \(state)")
    }
    
    func didUpdateData(data: ExampleData) {
        updateCells(data: data)
    }
    
    func updateCells(data data: ExampleData) {
        if let visibleCells = collectionView?.visibleCells() as? [CollectionViewCell] {
            for cell in visibleCells {
                updateCell(cell, data: data)
            }
        }
    }
    
    func updateCells(state state: DeviceState) {
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
