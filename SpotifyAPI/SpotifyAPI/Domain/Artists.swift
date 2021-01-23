//
//  Artists.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

public struct Artists: Codable {
    public let href: String
    public let items: [Artist]
    public let limit: Int
    public let next: String?
    public let offset: Int
    public let previous: String?
    public let total: Int
}
