//
//  SpotifyAPI.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation
import SpotifyDomain
import SpotifySearchDomain

public class SpotifyAPI: SearchAPIProtocol {
    
    public enum Error: Swift.Error {
        case emptyString
        case invalidData
        case connectivityError
    }
    
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func search(_ criteria: SearchCriteria, onCompletion: @escaping (SearchResult) -> Void) throws {
        guard !criteria.text.isEmpty else { throw Error.emptyString }
        let endpointURL = SpotifyAPI.getURLForCriteria(baseURL: url, criteria)
        client.get(from: endpointURL) { result in
            switch result {
            case let .success((data, response)):
                if response.statusCode == 200 {
                    do {
                        let searchItems = try SpotifyAPI.map(data: data, for: criteria.type)
                        onCompletion(.success(searchItems))
                    } catch {
                        onCompletion(.failure(Error.invalidData))
                    }
                } else {
                    onCompletion(.failure(Error.invalidData))
                }
            case .failure(_): onCompletion(.failure(Error.connectivityError))
            }
        }
    }
    
    private static func map(data: Data, for searchType: SearchType) throws -> [SearchItem] {
        switch searchType {
        case .album: return try SpotifyDataMapper.mapAlbums(data)
        case .artist: return try SpotifyDataMapper.mapArtists(data)
        case .track: return try SpotifyDataMapper.mapTracks(data)
        }
    }
    
    public static func getURLForCriteria(baseURL: URL, _ criteria: SearchCriteria) -> URL {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + "/v1/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: criteria.text),
            URLQueryItem(name: "type", value: criteria.type.rawValue),
            URLQueryItem(name: "offset", value: "\(criteria.offset)"),
            URLQueryItem(name: "limit", value: "\(criteria.limit)")
        ].compactMap { $0 }
        return components.url!
    }
}
