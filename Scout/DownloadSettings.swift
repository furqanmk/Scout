//
//  DownloadSettings.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation

class DownloadSettings {
    public static var requestTimeoutSeconds = 60.0
    public static var maximumSimultaneousDownloads = 50
    public static var requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
}
