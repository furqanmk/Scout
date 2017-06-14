//
//  DownloadManager.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation

public class DownloadManager<T: DataConvertible> {
    
    init() {
        cache = Cache()
        requests = [:]
    }
    
    /// Create a new manager
    static func new<T: DataConvertible>(caller: T.Type) -> DownloadManager<T> {
        return DownloadManager<T>()
    }
    
    /// Cache used by this manager
    public var cache: Cache<T>
    
    /// Download requests in progress
    public var requests: [String: DownloadRequest<T>]
    
    /// Downloads the asset from network
    @discardableResult public func fetch(url: String, progress: ((Double) -> Void)?, success: @escaping (T) -> Void, failure: @escaping (DownloadError) -> Void) -> DownloadRequest<T>? {
        
        if let cachedObject = cache.retrieve(url) {
            success(cachedObject)
            return nil
        }
        
        // Checks if there is any pending download for the same URL. If yes, simply appends the handlers. Otherwise creates a new task
        if let pending = requests[url] {
            pending.appendHandlers(progress: progress, success: success, failure: failure)
            return pending
        } else {
            return DownloadRequest(path: url, progress: progress, success: { [weak self] (result) in
                self?.cache.save(result, forUrl: url)
                success(result)
                }, failure: failure)
        }
    }
}
