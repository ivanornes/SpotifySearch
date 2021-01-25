//
//  SearchCellController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit
import SpotifyDomain

public final class AlbumSearchCellController: NSObject, UITableViewDataSource {
    
    private let reuseIdentifier = "AlbumSearchCell"
    
    private let model: Album
    
    public init(model: Album) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AlbumTableViewCell
        cell.configure(with: model)
        return cell
    }
}
