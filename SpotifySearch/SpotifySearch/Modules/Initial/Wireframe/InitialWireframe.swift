//
//  InitialWireframe.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 23/1/21.
//

import UIKit

public final class InitialWireframe {
    
    private init() {}
    
    public static func composeUI() -> UIViewController {
        let vc = makeInitialViewController(title: "Initial")
        return vc
    }
    
    private static func makeInitialViewController(title: String) -> InitialViewController {
        let vc = InitialViewController.instantiateInitialViewController(from: "Initial")
        vc.title = title
        return vc
    }
}
