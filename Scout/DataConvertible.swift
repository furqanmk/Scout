//
//  DataConvertible.swift
//  Scout
//
//  Created by Furqan on 14/06/2017.
//  Copyright © 2017 Furqan Muhammad Khan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public protocol DataConvertible {
    associatedtype Result
    
    static func convertFromData(_ data:Data) -> Result?
}

public protocol DataRepresentable {
    
    func asData() -> Data!
}

private let imageSync = NSLock()

extension UIImage : DataConvertible, DataRepresentable {
    
    public typealias Result = UIImage
    
    static func safeImageWithData(_ data: Data) -> Result? {
        imageSync.lock()
        let image = UIImage(data: data)
        imageSync.unlock()
        return image
    }
    
    public class func convertFromData(_ data: Data) -> Result? {
        let image = UIImage.safeImageWithData(data)
        return image
    }
    
    public func asData() -> Data! {
        return self.data() as Data!
    }
    
}

extension String : DataConvertible, DataRepresentable {
    
    public typealias Result = String
    
    public static func convertFromData(_ data: Data) -> Result? {
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string as Result?
    }
    
    public func asData() -> Data! {
        return self.data(using: String.Encoding.utf8)
    }
    
}

extension Data : DataConvertible, DataRepresentable {
    
    public typealias Result = Data
    
    public static func convertFromData(_ data: Data) -> Result? {
        return data
    }
    
    public func asData() -> Data! {
        return self
    }
}

/// Dependency on SwiftyJSON
extension JSON : DataConvertible, DataRepresentable {
    public typealias Result = JSON
    
    public static func convertFromData(_ data: Data) -> Result? {
        return JSON(data: data)
    }
    
    public func asData() -> Data! {
        do {
            return try self.rawData()
        } catch {
            Logger.error(message: "Could not convert JSON to Data.")
            return nil
        }
    }
    
}
