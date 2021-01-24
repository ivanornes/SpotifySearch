//
//  InitialViewController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 23/1/21.
//

import UIKit

final class InitialViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let vc = SearchControllerWireframe.composeUI()
        return UISearchController(searchResultsController: vc)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    func setupSearchController() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
