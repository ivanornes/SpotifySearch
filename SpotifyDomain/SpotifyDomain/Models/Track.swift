//
//  Track.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Track {
    public let album: Album
    public let artists: [Artist]
    public let availableMarkets: [String]
    public let discNumber: Int
    public let durationMS: Int
    public let explicit: Bool
    public let externalIDS: ExternalIDS
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let isLocal: Bool
    public let name: String
    public let popularity: Int
    public let previewURL: String?
    public let trackNumber: Int
    public let type: String
    public let uri: String
    
    public init(album: Album,
                artists: [Artist],
                availableMarkets: [String],
                discNumber: Int,
                durationMS: Int,
                explicit: Bool,
                externalIDS: ExternalIDS,
                externalUrls: ExternalUrls,
                href: String,
                id: String,
                isLocal: Bool,
                name: String,
                popularity: Int,
                previewURL: String?,
                trackNumber: Int,
                type: String,
                uri: String) {
        self.album = album
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.discNumber = discNumber
        self.durationMS = durationMS
        self.explicit = explicit
        self.externalIDS = externalIDS
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.isLocal = isLocal
        self.name = name
        self.popularity = popularity
        self.previewURL = previewURL
        self.trackNumber = trackNumber
        self.type = type
        self.uri = uri
    }
}
