//
//  GitHubRepositoryDetailCountViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubRepositoryDetailCountViewController: UITableViewController, Storyboardable {

    // MARK: - Outlet

    @IBOutlet private weak var starIconImageBackgroundView: UIView! {
        didSet {
            starIconImageBackgroundView.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet private weak var starCountLabel: UILabel!

    @IBOutlet private weak var watcherIconImageBackgroundView: UIView! {
        didSet {
            watcherIconImageBackgroundView.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet private weak var watcherCountLabel: UILabel!

    @IBOutlet private weak var forkIconImageBackgroundView: UIView! {
        didSet {
            forkIconImageBackgroundView.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet private weak var forkCountLabel: UILabel!

    @IBOutlet private weak var issueIconImageBackgroundView: UIView! {
        didSet {
            issueIconImageBackgroundView.layer.cornerRadius = 4.0
        }
    }
    @IBOutlet private weak var issueCountLabel: UILabel!

    // MARK: - Property

    var presenter: GitHubRepositoryDetailCountPresenter!

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.heightAnchor.constraint(equalToConstant: 300).isActive = true

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

    // MARK: - Private

    private func showDetail(gitHubRepository: GitHubRepository) {
        starCountLabel.text = gitHubRepository.stargazersCount.description
        watcherCountLabel.text = gitHubRepository.watchersCount.description
        forkCountLabel.text = gitHubRepository.forksCount.description
        issueCountLabel.text = gitHubRepository.openIssuesCount.description
    }
}

// MARK: - GitHubRepositoryDetailCountView

extension GitHubRepositoryDetailCountViewController: GitHubRepositoryDetailCountView {

    func showGitHubRepositoryDetailCount(gitHubRepository: GitHubRepository) {
        showDetail(gitHubRepository: gitHubRepository)
    }
}
