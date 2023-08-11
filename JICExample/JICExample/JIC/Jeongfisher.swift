//
//  Jeongfisher.swift
//  JICExample
//
//  Created by 유정주 on 2023/08/11.
//

import UIKit

public typealias JFImage = UIImage
public typealias JFImageView = UIImageView
public typealias JFData = Data

public struct JeongfisherWrapper<Base> {
    
    // MARK: - Properties
    public let base: Base
    
    // MARK: - Methods
    public init(base: Base) {
        self.base = base
    }
}

public protocol QueenfisherCompatible: AnyObject {}

extension QueenfisherCompatible {
    public var jf: JeongfisherWrapper<Self> {
        return JeongfisherWrapper(base: self)
    }
}

// MARK: - Conforms Queenfisher Compatible
extension JFImage: QueenfisherCompatible {}
extension JFImageView: QueenfisherCompatible {}
