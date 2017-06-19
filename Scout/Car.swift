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
    
    let id: Int
    let firstRegistration: Date
    let address: String
    let make: Make
    let fuelType: FuelType
    let powerKW: Int
    let price: Int
    let mileage: Int
    let accidentFree: Bool
    var imageURLs: [String] = []
    
    init?(json: JSON) {
        guard
            let id = json["ID"].int,
            let firstRegistration = json["FirstRegistration"].stringValue.scoutDate,
            let address = json["Address"].string,
            let make = Make(rawValue: json["Make"].string ?? ""),
            let fuelType = FuelType(rawValue: json["FuelType"].string ?? ""),
            let powerKW = json["PowerKW"].int,
            let price = json["Price"].int,
            let mileage = json["Mileage"].int,
            let accidentFree = json["AccidentFree"].bool,
            let imageURLs = json["Images"].array
            else {
                return nil
        }
        self.id = id
        self.firstRegistration = firstRegistration
        self.address = address
        self.make = make
        self.fuelType = fuelType
        self.powerKW = powerKW
        self.price = price
        self.mileage = mileage
        self.accidentFree = accidentFree
        
        for url in imageURLs {
            if let imageURL = url.string {
                self.imageURLs.append(imageURL)
            }
        }
        
    }
}
