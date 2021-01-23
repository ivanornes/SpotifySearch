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
    public let discNumber, durationMS: Int
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
}
