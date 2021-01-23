//
//  Album.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Album {
    public let albumType: String
    public let artists: [Artist]
    public let availableMarkets: [String]
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let images: [Image]
    public let name: String
    public let releaseDate: String
    public let releaseDatePrecision: String
    public let totalTracks: Int
    public let type: String
    public let uri: String
}
