//
//  SearchEngineBuilder.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifySearchEngine
import SpotifyAPI

public final class SearchEngineBuilder {
    
    private lazy var urlSession: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["Accept": "application/json",
                                                      "Content-Type": "application/json",
                                                      "Authorization": "Bearer \(Constants.bearer)"]
        return URLSession(configuration: sessionConfiguration)
    }()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: urlSession)
    }()
    
    private lazy var spotifyAPI: SpotifyAPI = {
        SpotifyAPI(url: Constants.spotifyAPIURL, client: httpClient)
    }()
    
    lazy var build: SpotifySearchEngine = {
        SpotifySearchEngine(searchAPI: spotifyAPI)
    }()
}
