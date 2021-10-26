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

    private var gitHubRepository: GitHubRepository!

    // MARK: - Build

    static func build(
        headingViewController: GitHubRepositoryDetailHeadingViewController,
        countViewController: GitHubRepositoryDetailCountViewController,
        readMeViewController: GitHubRepositoryDetailReadMeViewController,
        gitHubRepository: GitHubRepository
    ) -> Self {
        let viewController = initViewController()

        viewController.components = [
            headingViewController,
            countViewController,
            readMeViewController
        ]

        viewController.gitHubRepository = gitHubRepository

        return viewController
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = gitHubRepository.name
    }

}
