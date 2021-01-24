//
//  SearchViewController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit

final class SearchViewController: UITableViewController, SearchViewProtocol {
    var presenter: SearchViewPresenterProtocol?
    
    var searchText: ((String) -> Void)!
    
    func show(_ sections: [TableCellController]...) {
    }
    
    func showError() {
    }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    searchText(searchController.searchBar.text!)
  }
}

