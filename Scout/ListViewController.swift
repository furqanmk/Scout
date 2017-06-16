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
        NotificationBar.sharedBar.show(message: "Loading \(CarCollection.shared.makes[0].uppercased()) models...", background: Theme.orange, permenantly: true, loadingIndicator: true, completion: nil)
        
        // Sets up pull-to-refresh
        setupPullToRefresh()
        
        // Sets badge
        tabBarController?.tabBar.items?.last?.badgeColor = Theme.orange
        showBadgeUpdated()
        
        // Listens to favorite notification to update the badge
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Notification"), object: nil, queue: nil) { (notification) in
            self.showBadgeUpdated()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
        showBadgeUpdated()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideBadge()
    }
    
    /// Shows updated count of favorites on the badge
    func showBadgeUpdated() {
        self.tabBarController?.tabBar.items?.last?.badgeValue = "\(CarCollection.shared.favorites.count)"
    }
    
    /// Hides badge
    func hideBadge() {
        self.tabBarController?.tabBar.items?.last?.badgeValue = nil
    }
    
    /// Allows pull to refresh
    func setupPullToRefresh() {
        let spring = collectionView?.addSpringRefresh(position: .top, actionHandlere: { _ in
            
            NotificationBar.sharedBar.show(message: "Loading \(CarCollection.shared.makes[0]) models...", background: Theme.orange, permenantly: true, loadingIndicator: true, completion: nil)
            
            CarCollection.shared.fetch()
        })
        spring?.unExpandedColor = UIColor.gray
        spring?.expandedColor = Theme.blue
        spring?.readyColor = Theme.orange
        spring?.affordanceMargin = 0
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
        cell.indexPath = indexPath
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                NotificationBar.sharedBar.hide()
            }
        }
        
        collectionView?.reloadData()
    }
}

