//
//  SearchControllerWireframe.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit
import SpotifySearchDomain

final class SearchControllerWireframe {
    private init() {}
    
    public static func composeUI(searchEngine: SearchEngineProtocol) -> UISearchController {
        let vc = makeSearchViewController(title: "Search")
        let interactor = SearchViewInteractor(searchEngine: searchEngine)
        let presenter = SearchViewPresenter(view: vc, interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
        vc.searchText = interactor.searchText
        let searchVC = UISearchController(searchResultsController: vc)
        searchVC.searchResultsUpdater = vc
        return searchVC
    }
    
    private static func makeSearchViewController(title: String) -> SearchViewController {
        let vc = SearchViewController.instantiateInitialViewController(from: "Search")
        vc.title = title
        return vc
    }
}
