//
//  Artist.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Artist: Codable {
    public let externalUrls: ExternalUrls
    public let followers: Followers?
    public let genres: [String]?
    public let href: String
    public let id: String
    public let images: [Image]?
    public let name: String
    public let popularity: Int?
    public let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}
