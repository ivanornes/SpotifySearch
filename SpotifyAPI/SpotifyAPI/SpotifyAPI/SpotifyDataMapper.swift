//
//  SpotifyDataMapper.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain
import SpotifySearchDomain

internal class SpotifyDataMapper {
    internal static func mapArtists(_ data: Data) throws -> [SearchItem] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(APIArtistSearchResponse.self, from: data)
        return response.artists.items.map { $0.artist }
    }
    
    internal static func mapAlbums(_ data: Data) throws -> [SearchItem] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(APIAlbumsSearchResponse.self, from: data)
        return response.albums.items.map { $0.album }
    }
    
    internal static func mapTracks(_ data: Data) throws -> [SearchItem] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(APITrackSearchResponse.self, from: data)
        return response.tracks.items.map { $0.track }
    }
}
