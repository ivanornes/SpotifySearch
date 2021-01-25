//
//  TrackTableViewCell.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 25/1/21.
//

import UIKit
import SpotifyDomain

class TrackTableViewCell: UITableViewCell {
    
    func configure(with track: Track) {
        textLabel?.text = track.name
    }
}
