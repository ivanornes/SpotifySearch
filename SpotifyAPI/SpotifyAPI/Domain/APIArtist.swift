//
//  APIArtist.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APIArtist: Codable {
    public let externalUrls: APIExternalUrls
    public let followers: APIFollowers?
    public let genres: [String]?
    public let href: String
    public let id: String
    public let images: [APIImage]?
    public let name: String
    public let popularity: Int?
    public let type: String
    public let uri: String
    
    public var artist: Artist {
        .init(externalUrls: externalUrls.externalUrls,
              followers: followers?.followers,
              genres: genres,
              href: href,
              id: id,
              images: images?.map { $0.image },
              name: name,
              popularity: popularity,
              type: type,
              uri: uri)
    }
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}
