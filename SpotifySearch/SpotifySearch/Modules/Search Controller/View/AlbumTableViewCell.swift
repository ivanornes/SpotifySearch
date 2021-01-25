//
//  AlbumTableViewCell.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 25/1/21.
//

import UIKit
import SpotifyDomain
import Kingfisher

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with album: Album) {
        nameLabel.text = album.name
        if let image = album.images.first {
            albumImageView.kf.setImage(with: URL(string: image.url)!,
                                        placeholder: ImageCache.shared.image(named: "placeholder"))
        } else {
            let resource: Resource? = nil
            albumImageView.kf.setImage(with: resource)
            albumImageView.image = ImageCache.shared.image(named: "placeholder")
        }
    }
}
