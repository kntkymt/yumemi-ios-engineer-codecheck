//
//  GitHubRepositoryDetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitHubRepositoryDetailHeadingPresenter: GitHubRepositoryDetailHeadingPresentation {

    // MARK: - Property

    private weak var view: GitHubRepositoryDetailHeadingView?

    private let gitHubRepository: GitHubRepository

    // MARK: - Initializer

    init(view: GitHubRepositoryDetailHeadingView, gitHubRepository: GitHubRepository) {
        self.view = view
        self.gitHubRepository = gitHubRepository
    }

    // MARK: - Lifecycle

    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showGitHubRepositoryDetailHeading(gitHubRepository: self.gitHubRepository)
        }
    }

    func viewWillAppear() {
    }

    func viewDidAppear() {
    }

    func viewDidStop() {
    }
}
