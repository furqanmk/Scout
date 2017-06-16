//
//  CarCell
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteToggleDelegate {
    func didToggleFavorite(cell: UICollectionViewCell)
}

class CarCell: UICollectionViewCell {
    
    @IBOutlet private weak var makeLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var firstRegistrationLabel: UILabel!
    @IBOutlet private weak var mileageLabel: UILabel!
    @IBOutlet private weak var powerLabel: UILabel!
    @IBOutlet private weak var fuelTypeLabel: UILabel!
    @IBOutlet private weak var accidentFreeLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    @IBOutlet private var carImages: [UIImageView]!
    
    @IBOutlet private weak var imageStack: UIStackView!
    @IBOutlet private weak var infoStack: UIStackView!
    
    var indexPath: IndexPath? {
        didSet { tag = indexPath!.item }
    }
    
    var favoriteToggleDelegate: FavoriteToggleDelegate?
    
    var car: Car? {
        didSet {
            if let car = car {
                makeLabel.text = car.make?.rawValue
                priceLabel.text = "€ \(car.price!)"
                firstRegistrationLabel.text = car.firstRegistration?.beautified
                mileageLabel.text = "\(car.mileage!) KM"
                powerLabel.text = "\(car.powerKW!) KW"
                fuelTypeLabel.text = car.fuelType?.rawValue
                accidentFreeLabel.isHidden = !car.accidentFree!
                favoriteSwitch.isOn = Favorites.ids.contains(car.id!)
                self.addressLabel.text = car.address

                guard car.imageURLs.count == 4 else {
                    return
                }
                
                for i in 0..<4 {
                    let url = car.imageURLs[i]
                    carImages[i].setImage(url: url)
                }
            }
        }
    }

    
    @IBAction func favoriteStateToggled(_ sender: UISwitch) {
        guard let car = car else {
            return
        }
        
        if sender.isOn {
            Favorites.addId(car.id!)
        } else {
            Favorites.removeId(car.id!)
        }
        
        NotificationCenter.default.post(name: Notification.Name("Notification"), object: nil, userInfo: ["Nigger":"Furqan"])
        
        
        favoriteToggleDelegate?.didToggleFavorite(cell: self)
    }
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let standardHeight = LayoutConstants.Cell.standardHeight
        let featuredHeight = LayoutConstants.Cell.featuredHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        accidentFreeLabel.alpha = delta
        addressLabel.alpha = delta
        favoriteSwitch.alpha = delta
        imageStack.alpha = delta
        infoStack.alpha = delta
    }
    
}
