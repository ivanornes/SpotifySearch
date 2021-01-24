//
//  InitialViewController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 23/1/21.
//

import UIKit

final class InitialViewController: UIViewController {
    
    var generateSearchController: (() -> UISearchController)!
    
    private lazy var searchController: UISearchController = generateSearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    func setupSearchController() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
