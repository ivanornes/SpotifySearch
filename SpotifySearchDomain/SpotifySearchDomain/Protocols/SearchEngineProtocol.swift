//
//  SearchEngineProtocol.swift
//  SpotifySearchDomain
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation

public protocol SearchEngineProtocol {
    func search(text: String, onResult: @escaping (Result<SearchEngineResult,Error>)->Void)
}
