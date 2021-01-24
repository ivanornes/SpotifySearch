//
//  APIAlbum.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APIAlbum: Codable {
    public let albumType: String
    public let artists: [APIArtist]
    public let availableMarkets: [String]
    public let externalUrls: APIExternalUrls
    public let href: String
    public let id: String
    public let images: [APIImage]
    public let name: String
    public let releaseDate: String
    public let releaseDatePrecision: String
    public let totalTracks: Int
    public let type: String
    public let uri: String

    public var album: Album {
        .init(albumType: albumType,
              artists: artists.map { $0.artist},
              availableMarkets: availableMarkets,
              externalUrls: externalUrls.externalUrls,
              href: href,
              id: id,
              images: images.map { $0.image },
              name: name,
              releaseDate: releaseDate,
              releaseDatePrecision: releaseDatePrecision,
              totalTracks: totalTracks,
              type: type,
              uri: uri)
    }
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}
