//
//  APIExternalUrls.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APIExternalUrls: Codable {
    public let spotify: String
    
    public var externalUrls: ExternalUrls {
        .init(spotify: spotify)
    }
}
