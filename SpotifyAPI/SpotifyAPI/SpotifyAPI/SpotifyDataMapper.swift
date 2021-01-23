//
//  SpotifyDataMapper.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain

internal class SpotifyDataMapper {
    internal static func map(_ data: Data) throws -> [SearchItem] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(ArtistSearchResponse.self, from: data)
        return response.artists.items
    }
}
