//
//  GitHubRepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitHubRepositoryDetailViewController: VStackViewController, Storyboardable {

    // MARK: - Property

    private var headingViewController: GitHubRepositoryDetailHeadingViewController!

    // MARK: - Build

    static func build(
        headingViewController: GitHubRepositoryDetailHeadingViewController,
        countViewController: GitHubRepositoryDetailCountViewController,
        readMeViewController: GitHubRepositoryDetailReadMeViewController
    ) -> Self {
        let viewController = initViewController()

        viewController.components = [
            headingViewController,
            countViewController,
            readMeViewController
        ]

        return viewController
    }

}
