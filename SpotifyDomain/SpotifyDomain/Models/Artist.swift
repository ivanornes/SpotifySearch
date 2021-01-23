//
//  Artist.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct ArtistSearchResponse: Codable {
    public let artists: Artists
}

public struct Artists: Codable {
    public let href: String
    public let items: [ArtistsItem]
    public let limit: Int
//    public let next: JSONNull?
    public let offset: Int
//    public let previous: JSONNull?
    public let total: Int
}

public struct ArtistsItem: Codable {
    public let externalUrls: ExternalUrls
    public let followers: Followers
    public let genres: [String]
    public let href: String
    public let id: String
    public let images: [ArtistsImage]
    public let name: String
    public let popularity: Int
    public let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

public struct ExternalUrls: Codable {
    public let spotify: String
}

public struct Followers: Codable {
//    public let href: JSONNull?
    public let total: Int
}

public struct ArtistsImage: Codable {
    public let height: Int
    public let url: String
    public let width: Int
}
