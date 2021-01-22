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

class SpotifyAPI {
    typealias SearchResult = Result<[SearchItem], Swift.Error>
    
    func search(_ text: String, onCompletion: @escaping (SearchResult) -> Void) {
        onCompletion(.success([]))
    }
}

class SearchSpotifyAPITests: XCTestCase {

    func test_searchRequest_returnsEmptyList() {
        let sut = makeSUT()
        
        sut.search("random-music-string-search") { result in
            switch result {
            case let .success(searchResults): XCTAssert(searchResults.isEmpty)
            case let .failure(error): XCTFail("Expected to fetch some data, got \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Helper
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> SpotifyAPI {
        let sut = SpotifyAPI()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
