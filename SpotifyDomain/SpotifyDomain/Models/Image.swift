//
//  Image.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Image: Hashable {
    public let height: Int
    public let url: String
    public let width: Int
    
    public init(height: Int, url: String, width: Int) {
        self.height = height
        self.url = url
        self.width = width
    }
}
