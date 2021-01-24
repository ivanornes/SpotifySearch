//
//  APITrack.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APITrack: Codable {
    public let album: APIAlbum
    public let artists: [APIArtist]
    public let availableMarkets: [String]
    public let discNumber, durationMS: Int
    public let explicit: Bool
    public let externalIDS: APIExternalIDS
    public let externalUrls: APIExternalUrls
    public let href: String
    public let id: String
    public let isLocal: Bool
    public let name: String
    public let popularity: Int
    public let previewURL: String?
    public let trackNumber: Int
    public let type, uri: String

    public var track: Track {
        .init(album: album.album,
              artists: artists.map { $0.artist },
              availableMarkets: availableMarkets,
              discNumber: discNumber,
              durationMS: durationMS,
              explicit: explicit,
              externalIDS: externalIDS.externalIDS,
              externalUrls: externalUrls.externalUrls,
              href: href,
              id: id,
              isLocal: isLocal,
              name: name,
              popularity: popularity,
              previewURL: previewURL,
              trackNumber: trackNumber,
              type: type,
              uri: uri)
    }
    
    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}
