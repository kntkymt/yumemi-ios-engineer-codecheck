//
//  SceneRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/23.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SceneRouter {

    enum Scene {
        case splash
        case main

        var viewController: UIViewController {
            switch self {
            case .splash: return SplashViewController.build()
            case .main: return MainViewController.build()
            }
        }
    }

    // MARK: - Static

    static let shared = SceneRouter()

    // MARK: - Property

    weak var rootViewController: RootViewController!

    // MARK: - Initializer

    private init() {}

    // MARK: - Public

    func route(to scene: Scene, animated: Bool, completion: ((UIViewController) -> Void)? = nil) {
        rootViewController.route(scene.viewController, animated: animated, completion: completion)
    }
}
