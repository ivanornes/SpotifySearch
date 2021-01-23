//
//  APIAlbums.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

struct APIAlbums: Codable {
    let href: String
    let items: [APIAlbum]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}
