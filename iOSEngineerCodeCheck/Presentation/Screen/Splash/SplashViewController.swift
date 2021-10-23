//
//  SplashViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/23.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

final class SplashViewController: UIViewController, Storyboardable {

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    // viewDidAppearでないと正常に動作しない
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        SceneRouter.shared.route(to: .main, animated: true)
    }
}
