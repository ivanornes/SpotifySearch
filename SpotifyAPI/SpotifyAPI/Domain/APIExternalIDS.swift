//
//  APIExternalIDS.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APIExternalIDS: Codable {
    public let isrc: String
    
    public var externalIDS: ExternalIDS {
        .init(isrc: isrc)
    }
}
