//
//  GitHubRepositoryDetailCountPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitHubRepositoryDetailCountPresenter: GitHubRepositoryDetailCountPresentation {

    // MARK: - Property

    private weak var view: GitHubRepositoryDetailCountView?

    private var gitHubRepository: GitHubRepository

    // MARK: - Initializer

    init(view: GitHubRepositoryDetailCountView, gitHubRepository: GitHubRepository) {
        self.view = view
        self.gitHubRepository = gitHubRepository
    }

    // MARK: - Lifecycle

    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showGitHubRepositoryDetailCount(gitHubRepository: self.gitHubRepository)
        }
    }

    func viewWillAppear() {
    }

    func viewDidAppear() {
    }

    func viewDidStop() {
    }
}
