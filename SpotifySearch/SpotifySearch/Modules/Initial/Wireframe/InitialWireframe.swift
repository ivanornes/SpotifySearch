//
//  InitialWireframe.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 23/1/21.
//

import UIKit
import SpotifySearchDomain

public final class InitialWireframe {
    
    private init() {}
    
    public static func composeUI(with searchEngine: SearchEngineProtocol) -> UIViewController {
        let vc = makeInitialViewController(title: "Initial")
        vc.generateSearchController = {
            let vc = SearchControllerWireframe.composeUI(searchEngine: searchEngine)
            return UISearchController(searchResultsController: vc)
        }
        return vc
    }
    
    private static func makeInitialViewController(title: String) -> InitialViewController {
        let vc = InitialViewController.instantiateInitialViewController(from: "Initial")
        vc.title = title
        return vc
    }
}
