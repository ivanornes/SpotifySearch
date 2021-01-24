//
//  Album.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Album: Hashable {
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
    
    public init(albumType: String,
                artists: [Artist],
                availableMarkets: [String],
                externalUrls: ExternalUrls,
                href: String,
                id: String,
                images: [Image],
                name: String,
                releaseDate: String,
                releaseDatePrecision: String,
                totalTracks: Int,
                type: String,
                uri: String) {
        self.albumType = albumType
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.totalTracks = totalTracks
        self.type = type
        self.uri = uri
    }
}
