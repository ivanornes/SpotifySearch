//
//  SearchEngineResult.swift
//  SpotifySearchDomain
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifyDomain

public final class SearchEngineResult {
    public let tracks: [Track]
    public let albums: [Album]
    public let artists: [Artist]
    
    public init(tracks: [Track], albums: [Album], artists: [Artist]) {
        self.tracks = tracks
        self.albums = albums
        self.artists = artists
    }
}
