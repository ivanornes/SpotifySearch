//
//  SpotifySearchEngine.swift
//  SpotifySearchEngine
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifyAPI
import SpotifyDomain
import SpotifySearchDomain

public final class SpotifySearchEngine: SearchEngineProtocol {
    
    private let searchAPI: SearchAPIProtocol
    
    public init(searchAPI: SearchAPIProtocol) {
        self.searchAPI = searchAPI
    }
    
    public func search(text: String, onResult: @escaping (Result<SearchEngineResult,Error>)->Void) throws {
        let group = DispatchGroup()
        var foundTracks: [Track] = []
        var foundAlbums: [Album] = []
        var foundArtists: [Artist] = []
        var errors: [Error] = []
        DispatchQueue.global().async {
            group.enter()
            let criteria = SearchCriteria(text: text, type: .track)
            do {
                try self.searchAPI.search(criteria, onCompletion: { result in
                    switch result {
                    case let .success(tracks): foundTracks.append(contentsOf: tracks as! [Track])
                    case let .failure(error): errors.append(error)
                    }
                })
                group.leave()
            } catch {
                errors.append(error)
                group.leave()
            }
        }
        DispatchQueue.global().async {
            group.enter()
            let criteria = SearchCriteria(text: text, type: .album)
            do {
                try self.searchAPI.search(criteria, onCompletion: { result in
                    switch result {
                    case let .success(albums): foundAlbums.append(contentsOf: albums as! [Album])
                    case let .failure(error): errors.append(error)
                    }
                })
                group.leave()
            } catch {
                errors.append(error)
                group.leave()
            }
        }
        DispatchQueue.global().async {
            group.enter()
            let criteria = SearchCriteria(text: text, type: .artist)
            do {
                try self.searchAPI.search(criteria, onCompletion: { result in
                    switch result {
                    case let .success(artists): foundArtists.append(contentsOf: artists as! [Artist])
                    case let .failure(error): errors.append(error)
                    }
                })
                group.leave()
            } catch {
                errors.append(error)
                group.leave()
            }
        }
        let workItem = DispatchWorkItem {
            if let error = errors.first {
                onResult(.failure(error))
            } else {
                let result = SearchEngineResult(tracks: foundTracks, albums: foundAlbums, artists: foundArtists)
                onResult(.success(result))
            }
        }
        group.notify(queue: DispatchQueue.global(), work: workItem)
    }
}
