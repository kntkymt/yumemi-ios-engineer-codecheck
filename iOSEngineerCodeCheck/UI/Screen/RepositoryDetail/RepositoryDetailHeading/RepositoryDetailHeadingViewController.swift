//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryDetailHeadingViewController: UIViewController, Storyboardable {

    // MARK: - Outlet
    
    @IBOutlet private weak var iconImageView: UIImageView!
    
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!

    // MARK: - Property

    var presenter: RepositoryDetailHeadingPresentation!

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
        iconImageView.load(gitHubRepository.owner.avatarUrl)

        ownerNameLabel.text = gitHubRepository.owner.login
        repositoryNameLabel.text = gitHubRepository.name
        if let description = gitHubRepository.description {
            repositoryDescriptionLabel.isHidden = false
            repositoryDescriptionLabel.text = description
        } else {
            repositoryDescriptionLabel.isHidden = true
            repositoryDescriptionLabel.text = ""
        }

        if let language = gitHubRepository.language {
            languageLabel.isHidden = false
            languageLabel.text = "Written in \(language)"
        } else {
            languageLabel.isHidden = true
            languageLabel.text = ""
        }
    }
}

// MARK: - GitHubRepositoryDetailView

extension RepositoryDetailHeadingViewController: RepositoryDetailHeadingView {
    
    func showGitHubRepositoryDetailHeading(gitHubRepository: GitHubRepository) {
        showDetail(gitHubRepository: gitHubRepository)
    }
}
