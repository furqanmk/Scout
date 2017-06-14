//
//  DownloadImageManager.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import UIKit

public class DownloadImageManager {
    
    /// Shared manager used for image downloading.
    public static var shared: DownloadManager<UIImage> {
        guard let s = _singleton else {
            _singleton = DownloadManager<UIImage>()
            return _singleton!
        }
        return s
    }
    static private var _singleton: DownloadManager<UIImage>?
    
}
