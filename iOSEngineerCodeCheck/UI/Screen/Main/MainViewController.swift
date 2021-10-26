//
//  MainViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/23.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

final class MainViewController: UINavigationController, Storyboardable {

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = RepositorySearchViewController.build()
        viewController.presenter = RepositorySearchPresenter(view: viewController, gitHubRepositorySearchUsecase: AppContainer.shared.gitHubRepositorySearchUsecase)
        setViewControllers([viewController], animated: false)
    }
}
