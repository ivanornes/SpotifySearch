//
//  SpotifyAPITests.swift
//  SpotifyAPITests
//
//  Created by Ivan Ornes on 22/1/21.
//

import XCTest
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
                                                      "Authorization": "Bearer BQCT7oCDv8Ud23CAcCmj8-UPyHKw4P4TQDJXDK4mnXHz096hUzjyR8WoN1S1SkIffZStQkTpxsndmPNr6MGpRFm7ZEzcnbDuesat9pr0aNLdb1aU2vvCG6V7lJLWm_gQH02L42kDKADSs0I"]
        return URLSession(configuration: sessionConfiguration)
    }
}
