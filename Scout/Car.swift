//
//  Car.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Car {
    
    enum FuelType: String {
        case Diesel
        case Benzin
    }
    
    enum Make: String {
        case BMW
        case Audi
        case Mercedes = "Mercedes-Benz"
    }
    
    let id: Int?
    let firstRegistration: Date?
    let address: String?
    let make: Make?
    let fuelType: FuelType?
    let powerKW: Int?
    let price: Int?
    let mileage: Int?
    let accidentFree: Bool?
    var imageURLs: [String] = []
    
    init(json: JSON) {
        self.id = json["ID"].int
        self.firstRegistration = json["FirstRegistration"].stringValue.scoutDate
        self.address = json["Address"].string
        self.make = Make(rawValue: json["Make"].string!)
        self.fuelType = FuelType(rawValue: json["FuelType"].string!)
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
