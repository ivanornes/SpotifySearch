//
//  TableCellController.swift
//  SpotifySearch
//
//  Created by Ivan Ornes on 24/1/21.
//

import UIKit

public struct TableCellController {
    let id: AnyHashable
    let dataSource: UITableViewDataSource
    let delegate: UITableViewDelegate?
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource as? UITableViewDelegate
    }
}

extension TableCellController: Equatable {
    public static func == (lhs: TableCellController, rhs: TableCellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension TableCellController: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
