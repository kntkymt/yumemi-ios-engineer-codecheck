//
//  GitHubRepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

final class GitHubRepositoryDetailViewController: VStackViewController, Storyboardable, WebViewShowable {

    // MARK: - Property

    private var gitHubRepository: GitHubRepository!

    // MARK: - Build

    static func build(
        headingViewController: RepositoryDetailHeadingViewController,
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

    // MARK: - Action

    @IBAction private func shareButtonDidTap(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [gitHubRepository.htmlUrl], applicationActivities: [])
        present(activityViewController, animated: true)
    }
}
