//
//  Storyboardable.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/23.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol Storyboardable {

    associatedtype Instance

    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static func initViewController() -> Instance
}

extension Storyboardable where Self: UIViewController {

    static var storyboardName: String {
        return self.description()
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }

    static func initViewController() -> Self {
        return storyboard.instantiateInitialViewController() as! Self
    }
}
