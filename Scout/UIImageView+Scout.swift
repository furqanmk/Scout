//
//  UIImageView+Scout.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import UIKit

public extension UIImageView {
    public func setImage(url: String) {
        DownloadImageManager.shared.fetch(url: url, progress: nil, success: { [weak self] (image) in
            self?.image = image
        }) { (error) in
            print(error)
        }
    }
}
