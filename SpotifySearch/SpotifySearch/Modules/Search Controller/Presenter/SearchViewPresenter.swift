//
//  SearchViewPresenter.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifySearchDomain
import SpotifyDomain

final class SearchViewPresenter: SearchViewPresenterProtocol {
    private weak var view: SearchViewProtocol?
    private let interactor: SearchViewInteractorInputProtocol
    
    init(view: SearchViewProtocol?,
         interactor: SearchViewInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

extension SearchViewPresenter: SearchViewInteractorOutputProtocol {
    
    func show(_ results: SearchEngineResult) {
        let trackCellControllers = getTrackCellControllers(from: results)
        let artistCellControllers = getArtistCellControllers(from: results)
        let albumCellControllers = getAlbumCellControllers(from: results)
        view?.show(trackCellControllers + artistCellControllers + albumCellControllers)
    }
    
    func getTrackCellControllers(from results: SearchEngineResult) -> [TableCellController] {
        var uniqueTracks: [Track] = []
        for track in results.tracks {
            if !uniqueTracks.contains(track) {
                uniqueTracks.append(track)
            }
        }
        return uniqueTracks.map {
            TableCellController(id: $0.uri, TrackSearchCellController(model: $0))
        }
    }

    func getAlbumCellControllers(from results: SearchEngineResult) -> [TableCellController] {
        var uniqueAlbums: [Album] = []
        for album in results.albums {
            if !uniqueAlbums.contains(album) {
                uniqueAlbums.append(album)
            }
        }
        return uniqueAlbums.map {
            TableCellController(id: $0.uri, AlbumSearchCellController(model: $0))
        }
    }
    
    func getArtistCellControllers(from results: SearchEngineResult) -> [TableCellController] {
        var uniqueArtists: [Artist] = []
        for artist in results.artists {
            if !uniqueArtists.contains(artist) {
                uniqueArtists.append(artist)
            }
        }
        return uniqueArtists.map {
            TableCellController(id: $0.uri, ArtistSearchCellController(model: $0))
        }
    }
    
    func showError() {
    }
}
