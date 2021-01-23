//
//  SpotifyAPI.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

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
    
    public func search(_ text: String, onCompletion: @escaping (SearchResult) -> Void) throws {
        guard !text.isEmpty else { throw Error.emptyString }
        client.get(from: url) { result in
            switch result {
            case .success((let data, let response)):
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
        onCompletion(.success([]))
    }
}
