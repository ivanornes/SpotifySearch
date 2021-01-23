//
//  HTTPClient.swift
//  SpotifyAPI
//
//  Created by Ivan Ornes on 23/1/21.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Swift.Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
