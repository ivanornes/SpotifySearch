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

class SpotifyAPI {
    typealias SearchResult = Result<[SearchItem], Swift.Error>
    
    enum Error: Swift.Error {
        case emptyString
    }
    
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func search(_ text: String, onCompletion: @escaping (SearchResult) -> Void) throws {
        guard !text.isEmpty else { throw Error.emptyString }
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
        let sut = SpotifyAPI(client: httpClient)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
