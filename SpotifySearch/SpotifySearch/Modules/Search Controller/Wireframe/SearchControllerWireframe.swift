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
        return vc
    }
    
    private static func makeSearchViewController(title: String) -> SearchViewController {
        let vc = SearchViewController()
        vc.title = title
        return vc
    }
}
