//
//  TrackSearchCellController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit
import SpotifyDomain

public final class TrackSearchCellController: NSObject, UITableViewDataSource {
    
    private let reuseIdentifier = "TrackSearchCell"
    
    private let model: Track
    
    public init(model: Track) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TrackTableViewCell
        cell.configure(with: model)
        return cell
    }
}
