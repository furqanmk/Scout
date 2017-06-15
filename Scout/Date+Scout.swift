//
//  Date+Scout.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation

extension Date {
    var beautified: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yy"
        return dateFormatter.string(from: self)
    }
}
