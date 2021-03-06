//
//  SearchViewProtocols.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import Foundation
import SpotifySearchDomain

public protocol SearchViewProtocol: class {
    func show(_ sections: [TableCellController]...)
    func showError()
}

public protocol SearchViewPresenterProtocol: class {
}

public protocol SearchViewInteractorInputProtocol: class {
}

public protocol SearchViewInteractorOutputProtocol: class {
    func show(_ results: SearchEngineResult)
    func showError()
}
