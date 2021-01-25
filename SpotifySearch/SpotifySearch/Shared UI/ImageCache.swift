//
//  ImageCache.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 25/1/21.
//

import UIKit

final class ImageCache {
    private init() {}
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    func image(named name: String) -> UIImage? {
        if let image = cache.object(forKey: name as NSString) {
            return image
        } else {
            if let image = UIImage(named: name) {
                cache.setObject(image, forKey: name as NSString)
                return image
            }
            return nil
        }
    }
}
