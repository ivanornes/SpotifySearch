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
    
    public static func composeUI(searchEngine: SearchEngineProtocol) -> UIViewController {
        let vc = makeSearchViewController(title: "Search")
        let interactor = SearchViewInteractor(searchEngine: searchEngine)
        let presenter = SearchViewPresenter(view: vc, interactor: interactor)
        vc.presenter = presenter
        interactor.presenter = presenter
        return vc
    }
    
    private static func makeSearchViewController(title: String) -> SearchViewController {
        let vc = SearchViewController()
        vc.title = title
        return vc
    }
}
