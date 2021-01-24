//
//  SearchViewInteractor.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifySearchEngine
import SpotifySearchDomain

final class SearchViewInteractor: SearchViewInteractorInputProtocol {
    weak var presenter: SearchViewInteractorOutputProtocol?
    
    let searchEngine: SearchEngineProtocol
    
    init(searchEngine: SearchEngineProtocol) {
        self.searchEngine = searchEngine
    }
}
