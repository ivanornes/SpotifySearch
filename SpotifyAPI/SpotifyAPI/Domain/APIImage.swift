//
//  Image.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APIImage: Codable {
    public let height: Int
    public let url: String
    public let width: Int
    
    public var image: Image {
        .init(height: height, url: url, width: width)
    }
}
