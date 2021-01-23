//
//  APIArtist.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct APIArtist: Codable {
    public let externalUrls: APIExternalUrls
    public let followers: APIFollowers?
    public let genres: [String]?
    public let href: String
    public let id: String
    public let images: [APIImage]?
    public let name: String
    public let popularity: Int?
    public let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}
