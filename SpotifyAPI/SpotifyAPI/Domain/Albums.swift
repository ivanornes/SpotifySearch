//
//  Albums.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

struct Albums: Codable {
    let href: String
    let items: [Album]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}
