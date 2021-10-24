//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubRepositoryDetailViewController: UIViewController, Storyboardable {

    // MARK: - Outlet
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    // MARK: - Property

    var presenter: GitHubRepositoryDetailPresenter!

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

    // MARK: - Private

    private func showDetail(gitHubRepository: GitHubRepository) {
        titleLabel.text = gitHubRepository.fullName
        languageLabel.text = "Written in \(gitHubRepository.language ?? "")"
        starLabel.text = "\(gitHubRepository.stargazersCount) stars"
        watchersLabel.text = "\(gitHubRepository.watchersCount) watchers"
        forksLabel.text = "\(gitHubRepository.forksCount) forks"
        issuesLabel.text = "\(gitHubRepository.openIssuesCount) open issues"
        imageView.load(gitHubRepository.owner.avatarUrl)
    }
}

// MARK: - GitHubRepositoryDetailView

extension GitHubRepositoryDetailViewController: GitHubRepositoryDetailView {
    
    func showGitHubRepositoryDetail(gitHubRepository: GitHubRepository) {
        showDetail(gitHubRepository: gitHubRepository)
    }
}
