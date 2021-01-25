//
//  ArtistTableViewCell.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 25/1/21.
//

import UIKit
import SpotifyDomain
import Kingfisher

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with artist: Artist) {
        nameLabel.text = artist.name
        if let image = artist.images?.first {
            artistImageView.kf.setImage(with: URL(string: image.url)!,
                                        placeholder: ImageCache.shared.image(named: "placeholder"))
        } else {
            let resource: Resource? = nil
            artistImageView.kf.setImage(with: resource)
            artistImageView.image = ImageCache.shared.image(named: "placeholder")
        }
    }
}
