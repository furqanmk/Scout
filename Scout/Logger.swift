//
//  Logger.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation


public struct Logger {
    
    fileprivate static let Tag = "[SCOUT]"
    
    fileprivate enum Level : String {
        case Debug = "[DEBUG]"
        case Error = "[ERROR]"
    }
    
    fileprivate static func log(_ level: Level, _ message: @autoclosure () -> String, _ error: DownloadError? = nil) {
        if let error = error {
            print("\(Tag)\(level.rawValue) \(message()) with error \(error)")
        } else {
            print("\(Tag)\(level.rawValue) \(message())")
        }
    }
    
    static func debug(message: @autoclosure () -> String, error: DownloadError? = nil) {
        #if DEBUG
            log(.Debug, message, error)
        #endif
    }
    
    static func error(message: @autoclosure () -> String, error: DownloadError? = nil) {
        log(.Error, message, error)
    }
    
}

