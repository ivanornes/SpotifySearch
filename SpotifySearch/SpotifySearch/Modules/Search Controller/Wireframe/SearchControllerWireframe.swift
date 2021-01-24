//
//  SearchControllerWireframe.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit

final class SearchControllerWireframe {
    private init() {}
    
    public static func composeUI() -> UIViewController {
        let vc = makeSearchViewController(title: "Search")
        let interactor = SearchViewInteractor()
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
