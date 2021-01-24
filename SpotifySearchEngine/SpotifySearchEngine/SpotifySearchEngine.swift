//
//  SpotifySearchEngine.swift
//  SpotifySearchEngine
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifyAPI
import SpotifyDomain
import SpotifySearchDomain

public final class SpotifySearchEngine {
    
    let searchAPI: SearchAPIProtocol
    
    init(searchAPI: SearchAPIProtocol) {
        self.searchAPI = searchAPI
    }
    
    func search(searchCriteria: SearchCriteria, onResult: @escaping (Result<[SearchItem],Error>)->Void) throws {
        try searchAPI.search(searchCriteria, onCompletion: onResult)
    }
}
