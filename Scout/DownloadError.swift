//
//  DownloadError.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation

public enum DownloadError {
    case invalidUrl
    case invalidResponse
    case not200
    case other(error: Error?)
}
