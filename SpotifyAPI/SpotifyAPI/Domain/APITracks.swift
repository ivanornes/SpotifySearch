//
//  APITracks.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct APITracks: Codable {
    public let href: String
    public let items: [APITrack]
    public let limit: Int
    public let next: String
    public let offset: Int
    public let previous: String?
    public let total: Int
}
