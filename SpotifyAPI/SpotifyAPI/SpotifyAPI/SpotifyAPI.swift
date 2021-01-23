//
//  SpotifyAPI.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public enum SearchType: String {
    case album, artist, track
}

public struct SearchCriteria {
    public let text: String
    public let type: SearchType
    public let offset: UInt
    public let limit: UInt
    
    public init(text: String, type: SearchType, offset: UInt = 0, limit: UInt = 20) {
        self.text = text
        self.type = type
        self.offset = offset
        self.limit = limit
    }
}

public class SpotifyAPI {
    public typealias SearchResult = Result<[SearchItem], Swift.Error>
    
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
        client.get(from: getURLForCriteria(criteria)) { result in
            switch result {
            case let .success((data, response)):
                if response.statusCode == 200 {
                    do {
                        let searchItems = try SpotifyDataMapper.map(data)
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
    
    public func getURLForCriteria(_ criteria: SearchCriteria) -> URL {
        var components = URLComponents()
        components.scheme = url.scheme
        components.host = url.host
        components.path = url.path + "/v1/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: criteria.text),
            URLQueryItem(name: "type", value: criteria.type.rawValue)
        ].compactMap { $0 }
        return components.url!
    }
}
