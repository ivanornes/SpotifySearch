//
//  SearchAPIProtocol.swift
//  SpotifyDomain
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation

public protocol SearchAPIProtocol {
    func search(_ criteria: SearchCriteria, onCompletion: @escaping (SearchResult) -> Void) throws
}
