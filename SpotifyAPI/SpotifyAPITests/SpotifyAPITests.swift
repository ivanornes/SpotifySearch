//
//  SpotifyAPITests.swift
//  SpotifyAPITests
//
//  Created by Ivan Ornes on 22/1/21.
//

import XCTest
@testable import SpotifyAPI

struct SearchItem {
}

protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Swift.Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

class SpotifyHTTPClient: HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
    }
}

class SpotifyDataMapper {
    static func map(_ data: Data) throws -> [SearchItem] {
        return []
    }
}

class SpotifyAPI {
    typealias SearchResult = Result<[SearchItem], Swift.Error>
    
    enum Error: Swift.Error {
        case emptyString
        case invalidData
        case connectivityError
    }
    
    let url: URL
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func search(_ text: String, onCompletion: @escaping (SearchResult) -> Void) throws {
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

class SearchSpotifyAPITests: XCTestCase {

    func test_searchRequest_returnsEmptyList() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for search result")
        
        try? sut.search("random-music-string-search") { result in
            switch result {
            case let .success(searchResults): XCTAssert(searchResults.isEmpty)
            case let .failure(error): XCTFail("Expected to fetch some data, got \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

    func test_searchRequest_returnsErrorSearchingEmptyString() {
        let sut = makeSUT()
        do {
            try sut.search("") { _ in
                XCTFail("Expected to throw exception")
            }
            XCTFail("Expected to throw exception")
        } catch {
        }
    }
    
    // MARK: Helper
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> SpotifyAPI {
        let httpClient = SpotifyHTTPClient()
        let url = makeURL()
        let sut = SpotifyAPI(url: url, client: httpClient)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    func makeURL() -> URL {
        URL(string: "https://api.spotify.com/v1/search?")!
    }
}
