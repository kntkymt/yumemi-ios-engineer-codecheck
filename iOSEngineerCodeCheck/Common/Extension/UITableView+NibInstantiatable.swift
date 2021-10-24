//
//  UITableView+NibInstantiatable.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UITableView {

    func register<Cell: NibInstantiatable>(_ cellType: Cell.Type) {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }

    func dequeue<Cell: NibInstantiatable>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! Cell
    }

    func dequeue<Cell: NibInstantiatable>(_ cellType: Cell.Type, for indexPath: IndexPath, with dependency: Cell.Dependency) -> Cell {
        let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! Cell
        cell.inject(dependency)
        
        return cell
    }
}
