//
//  APIFollowers.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct APIFollowers: Codable {
    public let href: String?
    public let total: Int
    
    public var followers: Followers {
        .init(href: href, total: total)
    }
}
