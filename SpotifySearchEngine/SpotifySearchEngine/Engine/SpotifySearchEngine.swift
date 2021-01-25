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
    private let operationQueue = OperationQueue()
    private var workItem: DispatchWorkItem?
    private var foundTracks: [Track] = []
    private var foundAlbums: [Album] = []
    private var foundArtists: [Artist] = []
    private var errors: [Error] = []
    
    public init(searchAPI: SearchAPIProtocol) {
        self.searchAPI = searchAPI
    }
    
    public func search(text: String, onResult: @escaping (Result<SearchEngineResult,Error>)->Void) {
        workItem?.cancel()
        operationQueue.cancelAllOperations()
        DispatchQueue.global().async(flags: .barrier) {
            self.foundTracks.removeAll()
            self.foundAlbums.removeAll()
            self.foundArtists.removeAll()
            self.errors.removeAll()
        }
        
        let group = DispatchGroup()
        operationQueue.addOperation {
            group.enter()
            group.enter()
            group.enter()
            do {
                try self.searchAPI.search(SearchCriteria(text: text, type: .track), onCompletion: { result in
                    switch result {
                    case let .success(tracks):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.foundTracks.append(contentsOf: tracks as! [Track])
                        }
                    case let .failure(error):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.errors.append(error)
                        }
                    }
                    group.leave()
                })
                try self.searchAPI.search(SearchCriteria(text: text, type: .album), onCompletion: { result in
                    switch result {
                    case let .success(albums):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.foundAlbums.append(contentsOf: albums as! [Album])
                        }
                    case let .failure(error):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.errors.append(error)
                        }
                    }
                    group.leave()
                })
                try self.searchAPI.search(SearchCriteria(text: text, type: .artist), onCompletion: { result in
                    switch result {
                    case let .success(artists):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.foundArtists.append(contentsOf: artists as! [Artist])
                        }
                    case let .failure(error):
                        DispatchQueue.global().async(flags: .barrier) {
                            self.errors.append(error)
                        }
                    }
                    group.leave()
                })
            } catch {
                DispatchQueue.global().async(flags: .barrier) {
                    self.errors.append(error)
                }
                group.leave()
                group.leave()
                group.leave()
            }
        }
        
        workItem = DispatchWorkItem {
            DispatchQueue.global().sync() {
                if !self.foundTracks.isEmpty ||
                    !self.foundAlbums.isEmpty ||
                    !self.foundArtists.isEmpty {
                    let result = SearchEngineResult(tracks: self.foundTracks,
                                                    albums: self.foundAlbums,
                                                    artists: self.foundArtists)
                    onResult(.success(result))
                } else if let error = self.errors.first {
                    onResult(.failure(error))
                }
            }
            
        }
        group.notify(queue: DispatchQueue.global(), work: workItem!)
    }
}
