//
//  Car.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Car {
    var id: Int?
    var firstRegistration: Date?
    var address: String?
    var make: CarMake?
    var fuelType: CarFuelType?
    var powerKW: Int?
    var price: Int?
    var mileage: Int?
    var accidentFree: Bool?
    var imageURLs: [String] = []
    
    init(json: JSON) {
        self.id = json["ID"].int
        self.firstRegistration = json["FirstRegistration"].string?.scoutDate
        self.address = json["Address"].string
        self.make = CarMake(rawValue: json["Make"].string!)
        self.fuelType = CarFuelType(rawValue: json["FuelType"].string!)
        self.powerKW = json["PowerKW"].int
        self.price = json["Price"].int
        self.mileage = json["Mileage"].int
        self.accidentFree = json["AccidentFree"].bool
        
        for url in json["Images"].array! {
            if let imageURL = url.string {
                self.imageURLs.append(imageURL)
            }
        }
        
    }
}
