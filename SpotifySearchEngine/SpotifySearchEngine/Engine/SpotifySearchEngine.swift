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
    private var workItem: DispatchWorkItem?
    private var foundTracks: [Track] = []
    private var foundAlbums: [Album] = []
    private var foundArtists: [Artist] = []
    private var errors: [Error] = []
    
    public init(searchAPI: SearchAPIProtocol) {
        self.searchAPI = searchAPI
    }
    
    public func search(text: String, onResult: @escaping (Result<SearchEngineResult,Error>)->Void) throws {
        workItem?.cancel()
        DispatchQueue.global().async(flags: .barrier) {
            self.foundTracks.removeAll()
            self.foundAlbums.removeAll()
            self.foundArtists.removeAll()
            self.errors.removeAll()
        }
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async {
            group.enter()
            let criteria = SearchCriteria(text: text, type: .track)
            do {
                try self.searchAPI.search(criteria, onCompletion: { result in
                    switch result {
                    case let .success(tracks):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.foundTracks.append(contentsOf: tracks as! [Track])
                        }
                    case let .failure(error): self.errors.append(error)
                    }
                })
                group.leave()
            } catch {
                self.errors.append(error)
                group.leave()
            }
        }
        DispatchQueue.global().async {
            group.enter()
            let criteria = SearchCriteria(text: text, type: .album)
            do {
                try self.searchAPI.search(criteria, onCompletion: { result in
                    switch result {
                    case let .success(albums):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.foundAlbums.append(contentsOf: albums as! [Album])
                        }
                    case let .failure(error): self.errors.append(error)
                    }
                })
                group.leave()
            } catch {
                self.errors.append(error)
                group.leave()
            }
        }
        DispatchQueue.global().async {
            group.enter()
            let criteria = SearchCriteria(text: text, type: .artist)
            do {
                try self.searchAPI.search(criteria, onCompletion: { result in
                    switch result {
                    case let .success(artists):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.foundArtists.append(contentsOf: artists as! [Artist])
                        }
                    case let .failure(error): self.errors.append(error)
                    }
                })
                group.leave()
            } catch {
                self.errors.append(error)
                group.leave()
            }
        }
        workItem = DispatchWorkItem {
            if let error = self.errors.first {
                onResult(.failure(error))
            } else {
                DispatchQueue.global().sync() {
                    let result = SearchEngineResult(tracks: self.foundTracks,
                                                    albums: self.foundAlbums,
                                                    artists: self.foundArtists)
                    onResult(.success(result))
                }
            }
        }
        group.notify(queue: DispatchQueue.global(), work: workItem!)
    }
}
