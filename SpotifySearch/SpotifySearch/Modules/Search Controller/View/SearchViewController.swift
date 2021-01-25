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
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, TableCellController> = {
        .init(tableView: tableView, cellProvider: { tableView, indexPath, controller -> UITableViewCell? in
            controller.dataSource.tableView(tableView, cellForRowAt: indexPath)
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        configureTableView()
    }
    
    private func configureDataSource() {
        tableView.dataSource = dataSource
        dataSource.defaultRowAnimation = .top
    }
    
    private func configureTableView() {
        tableView.tableFooterView = .init()
        tableView.estimatedRowHeight = 64.0
    }
    
    func show(_ sections: [TableCellController]...) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, TableCellController>()
        sections.enumerated().forEach { section, cellControllers in
            snapshot.appendSections([section])
            snapshot.appendItems(cellControllers, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    func showError() {
    }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    searchText(searchController.searchBar.text!)
  }
}

