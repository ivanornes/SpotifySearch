//
//  SearchViewPresenter.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation

final class SearchViewPresenter: SearchViewPresenterProtocol {
    private weak var view: SearchViewProtocol?
    private let interactor: SearchViewInteractorInputProtocol
    
    init(view: SearchViewProtocol?,
         interactor: SearchViewInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

extension SearchViewPresenter: SearchViewInteractorOutputProtocol {
    func show(_ results: [Any]) {
    }
    
    func showError() {
    }
}
