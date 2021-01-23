//
//  Artist.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Artist {
    public let externalUrls: ExternalUrls
    public let followers: Followers?
    public let genres: [String]?
    public let href: String
    public let id: String
    public let images: [Image]?
    public let name: String
    public let popularity: Int?
    public let type: String
    public let uri: String
    
    public init(externalUrls: ExternalUrls,
                followers: Followers?,
                genres: [String]?,
                href: String,
                id: String,
                images: [Image]?,
                name: String,
                popularity: Int?,
                type: String,
                uri: String) {
        self.externalUrls = externalUrls
        self.followers = followers
        self.genres = genres
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.popularity = popularity
        self.type = type
        self.uri = uri
    }
}
