//
//  FavoritesViewController.swift
//  Scout
//
//  Created by Furqan on 15/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoriteCell"

class FavoritesViewController: UICollectionViewController {

    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CarCollection.shared.favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarCell
        cell.car = CarCollection.shared.favorites[indexPath.item]
        cell.indexPath = indexPath
        cell.favoriteToggleDelegate = self
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

extension FavoritesViewController: FavoriteToggleDelegate {
    
    func didToggleFavorite(cell: UICollectionViewCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        collectionView?.deleteItems(at: [indexPath])
    }
}
