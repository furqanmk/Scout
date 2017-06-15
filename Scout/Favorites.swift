//
//  Favorites.swift
//  Scout
//
//  Created by Furqan on 15/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation

class Favorites {
    static var ids: [Int] {
        guard let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] else {
            return []
        }
        return favorites
    }
    
    static func addId(_ id: Int) {
        var favoriteIds = ids
        if favoriteIds.contains(id) {
            return
        }
        favoriteIds.insert(id, at: 0)
        UserDefaults.standard.setValue(favoriteIds, forKey: "favorites")
    }
    
    static func removeId(_ id: Int) {
        var favoriteIds = ids
        if let index = favoriteIds.index(of: id) {
            favoriteIds.remove(at: index)
            UserDefaults.standard.setValue(favoriteIds, forKey: "favorites")
        }
    }
}
