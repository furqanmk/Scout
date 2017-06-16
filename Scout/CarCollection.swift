//
//  CarCollection.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CarCollectionDelegate {
    func didLoadCars()
}

class CarCollection {
    static let shared = CarCollection()
    private init() { }
    
    var delegate: CarCollectionDelegate?
    
    // Holds all the cars
    var list: [Car] = [ ]
    
    // Returns only the favorited cars
    var favorites: [Car] {
        return list.filter({ Favorites.ids.contains($0.id!) })
    }
    
    // Currently active request
    var request: DownloadRequest<JSON>!
    
    // Array Makes to allow cyclic loading
    var makes: [String] = ["all", "bmw", "audi", "mercedes-benz"]
    
    func fetch() {
        if request != nil {
            request.cancel()
        }
        
        // Applying reload cycling between makes
        let make = makes[0]
        makes.remove(at: 0)
        makes.append(make)
        
        self.request = DownloadRequest<JSON>(path: "http://sumamo.de/iOS-TechChallange/api/index/make=\(make).json",
        progress: nil,
        success: { [weak self] json in
            guard let cars = json["vehicles"].array else {
                return
            }
            self?.list.removeAll()
            
            for item in cars {
                let car = Car(json: item)
                self?.list.append(car)
            }
            self?.delegate?.didLoadCars()
        },
        failure: { error in
            print("Error loading cars.")
        })
    }
    
    func clear() {
        list = [ ]
        DownloadImageManager.shared.cache.clearCache()
    }
}
