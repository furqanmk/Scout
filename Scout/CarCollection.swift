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
    
    // Currently active request
    var request: DownloadRequest<JSON>!
    
    func fetch() {
        if request != nil {
            request.cancel()
        }
        self.request = DownloadRequest<JSON>(path: "http://sumamo.de/iOS-TechChallange/api/index/make=all.json",
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
            print("Error loading movies.")
        })
    }
    
    func clear() {
        list = [ ]
        DownloadImageManager.shared.cache.clearCache()
    }
}
