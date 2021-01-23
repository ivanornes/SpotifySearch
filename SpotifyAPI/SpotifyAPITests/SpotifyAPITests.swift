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
        let baseURL = makeURL()
        
        let criteria = SearchCriteria(text: "noisia", type: .artist)
        let url = SpotifyAPI.getURLForCriteria(baseURL: baseURL, criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=noisia&type=artist&offset=0&limit=20"))
    }

    func test_getURLForCriteria_correctlyComposesAlbumURL() {
        let baseURL = makeURL()
        
        let criteria = SearchCriteria(text: "korn", type: .album)
        let url = SpotifyAPI.getURLForCriteria(baseURL: baseURL, criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=korn&type=album&offset=0&limit=20"))
    }
    
    func test_getURLForCriteria_correctlyComposesTrackURL() {
        let baseURL = makeURL()
        
        let criteria = SearchCriteria(text: "Asking Alexandria", type: .track)
        let url = SpotifyAPI.getURLForCriteria(baseURL: baseURL, criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=Asking%20Alexandria&type=track&offset=0&limit=20"))
    }

    func test_getURLForCriteria_correctlyComposesTrackURLWithNonDefaultOffsetAndLimit() {
        let baseURL = makeURL()
        
        let criteria = SearchCriteria(text: "Asking Alexandria", type: .track, offset: 1, limit: 40)
        let url = SpotifyAPI.getURLForCriteria(baseURL: baseURL, criteria)
        
        XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=Asking%20Alexandria&type=track&offset=1&limit=40"))
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

    func test_searchRequest_artistSearchReturnsAPIArtistModels() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for search result")
        let criteria = SearchCriteria(text: "Danger", type: .artist)
        try? sut.search(criteria) { result in
            switch result {
            case let .success(searchResults):
                if !(searchResults is [APIArtist]) {
                    XCTFail("Expected an array of artists")
                }
            case let .failure(error): XCTFail("Expected to fetch some data, got \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

    func test_searchRequest_albumSearchReturnsAPIAlbumModels() {
        let sut = makeSUT()
        let exp = expectation(description: "Wait for search result")
        let criteria = SearchCriteria(text: "Neurosis", type: .album)
        try? sut.search(criteria) { result in
            switch result {
            case let .success(searchResults):
                if !(searchResults is [APIAlbum]) {
                    XCTFail("Expected an array of album")
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
                                                      "Authorization": "Bearer BQAlU1EUOJyD86HohG3c7VQSbaWEZOPk-xOObR_U3rUgfhFqY81bd5hg59tJg_ebGZiofF2tiabAi7sVPg_l8HhnVFFy42um6sNOhCnN3DfSgUJ_teyULocLrwH6J16oyhQ1CSw2B65TPeQ"]
        return URLSession(configuration: sessionConfiguration)
    }
}
