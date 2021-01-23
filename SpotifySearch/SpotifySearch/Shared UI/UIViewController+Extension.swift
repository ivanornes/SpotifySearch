//
//  UIViewController+Extension.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 23/1/21.
//

import UIKit

extension UIViewController {
    public class func instantiateInitialViewController(from name: String) -> Self {
        return instantiateInitialViewControllerFrom(name)
    }

    fileprivate class func instantiateInitialViewControllerFrom<T>(_ storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle(for: T.self as! AnyClass))
        return storyboard.instantiateInitialViewController() as! T
    }
}
