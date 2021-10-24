//
//  SplashViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/23.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController, Storyboardable {

    // MARK: - Property

    var presenter: SplashPresentation!

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    deinit {
        presenter.viewDidStop()
    }
}

// MARK: - SplashView

extension SplashViewController: SplashView {

    func routeToMain() {
        SceneRouter.shared.route(to: .main, animated: true)
    }
}
