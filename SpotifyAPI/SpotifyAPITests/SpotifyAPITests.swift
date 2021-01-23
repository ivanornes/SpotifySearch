//
//  SpotifyAPITests.swift
//  SpotifyAPITests
//
//  Created by Ivan Ornes on 22/1/21.
//

import XCTest
import SpotifyDomain
@testable import SpotifyAPI

class SearchSpotifyAPITests: XCTestCase {

    func test_getURLForCriteria_correctlyComposesArtistURL() {
        let sut = makeSUT()
        
        let criteria = SearchCriteria(text: "noisia", type: .artist)
        let url = sut.getURLForCriteria(criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=noisia&type=artist"))
    }

    func test_getURLForCriteria_correctlyComposesAlbumURL() {
        let sut = makeSUT()
        
        let criteria = SearchCriteria(text: "korn", type: .album)
        let url = sut.getURLForCriteria(criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=korn&type=album"))
    }
    
    func test_getURLForCriteria_correctlyComposesTrackURL() {
        let sut = makeSUT()
        
        let criteria = SearchCriteria(text: "Asking Alexandria", type: .track)
        let url = sut.getURLForCriteria(criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=Asking%20Alexandria&type=track"))
    }
    
    func test_searchRequest_returnsEmptyList() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for search result")
        let criteria = SearchCriteria(text: "random-music-string-search", type: .artist)
        try? sut.search(criteria) { result in
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
        let criteria = SearchCriteria(text: "", type: .artist)
        do {
            try sut.search(criteria) { _ in
                XCTFail("Expected to throw exception")
            }
            XCTFail("Expected to throw exception")
        } catch {
        }
    }
    
    func test_searchRequest_returnsArtistData() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for search result")
        let criteria = SearchCriteria(text: "Danger", type: .artist)
        try? sut.search(criteria) { result in
            switch result {
            case let .success(searchResults): XCTAssert(!searchResults.isEmpty)
            case let .failure(error): XCTFail("Expected to fetch some data, got \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

    func test_searchRequest_artistSearchReturnsArtistModels() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for search result")
        let criteria = SearchCriteria(text: "Danger", type: .artist)
        try? sut.search(criteria) { result in
            switch result {
            case let .success(searchResults):
                if (searchResults is [Artists]) {
                    XCTFail("Expected an array of artists")
                }
            case let .failure(error): XCTFail("Expected to fetch some data, got \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: Helper
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> SpotifyAPI {
        let session = makeURLSession()
        let httpClient = URLSessionHTTPClient(session: session)
        let url = makeURL()
        let sut = SpotifyAPI(url: url, client: httpClient)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(session, file: file, line: line)
        trackForMemoryLeaks(httpClient, file: file, line: line)
        return sut
    }
    
    func makeURL() -> URL {
        URL(string: "https://api.spotify.com")!
    }
    
    func makeURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.httpAdditionalHeaders = ["Accept": "application/json",
                                                      "Content-Type": "application/json",
                                                      "Authorization": "Bearer BQAl9tphrX9t53wM57JCqc2cuLUCO-DGJzFN41Wv74MmvUOUFicGgS7B64itd3WAEj94-pLK0zTgK2HNKWLSzY0InRy9F_NVDi5cIrAtG1-e3Tb4Avb8NX4CLoXCpDnaMFPKcuH21lCTfXA"]
        return URLSession(configuration: sessionConfiguration)
    }
}
