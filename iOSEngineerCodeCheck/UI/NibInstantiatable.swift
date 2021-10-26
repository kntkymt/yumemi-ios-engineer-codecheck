//
//  NibInstantiatable.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol NibInstantiatable {

    associatedtype Dependency

    func inject(_ dependency: Dependency)

    static var identifier: String { get }
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibInstantiatable {

    static var nibName: String {
        return String(describing: self)
    }

    static var identifier: String {
        return nibName
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
