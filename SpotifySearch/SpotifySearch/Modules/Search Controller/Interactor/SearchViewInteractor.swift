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
    
    func searchText(_ text: String) {
        guard !text.isEmpty else { return }
        searchEngine.search(text: text) { result in
            switch result {
            case let .success(searchResult): self.presenter?.show(searchResult)
            case .failure(_): break
            }
        }
    }
}
