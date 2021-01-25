//
//  ArtistSearchCellController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit
import SpotifyDomain

public final class ArtistSearchCellController: NSObject, UITableViewDataSource {
    
    private let reuseIdentifier = "ArtistSearchCell"
    
    private let model: Artist
    
    public init(model: Artist) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArtistTableViewCell
        cell.configure(with: model)
        return cell
    }
}
