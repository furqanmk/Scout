//
//  ListViewController.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CarCell"

class ListViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CarCollection.shared.delegate = self
        CarCollection.shared.fetch()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

// UICollectionViewDelegate, UICollectionViewDataSource
extension ListViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CarCollection.shared.list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarCell
        cell.car = CarCollection.shared.list[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = collectionViewLayout as! Layout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
}

/// Handles the result of car load
extension ListViewController: CarCollectionDelegate {
    func didLoadCars() {
        collectionView?.reloadData()
    }
}
