//
//  SearchCriteria.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation

public struct SearchCriteria {
    public let text: String
    public let type: SearchType
    public let offset: UInt
    public let limit: UInt
    
    public init(text: String, type: SearchType, offset: UInt = 0, limit: UInt = 20) {
        self.text = text
        self.type = type
        self.offset = offset
        self.limit = limit
    }
}
