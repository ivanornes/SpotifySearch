//
//  TrackTableViewCell.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 25/1/21.
//

import UIKit
import SpotifyDomain

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    func configure(with track: Track) {
        trackNameLabel.text = track.name
    }
}
