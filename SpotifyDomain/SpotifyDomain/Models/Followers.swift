//
//  Followers.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public struct Followers: Hashable {
    public let href: String?
    public let total: Int
    
    public init(href: String?, total: Int) {
        self.href = href
        self.total = total
    }
}
