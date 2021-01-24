//
//  SearchViewController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit

final class SearchViewController: UITableViewController, SearchViewProtocol {
    var presenter: SearchViewPresenterProtocol?
    
    func show(_ sections: [TableCellController]...) {
    }
    
    func showError() {
    }
}
