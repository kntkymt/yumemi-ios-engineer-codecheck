//
//  GitHubRepositorySearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitHubRepositorySearchPresenter: GitHubRepositorySearchPresentation {

    // MARK: - Property

    private weak var view: GitHubRepositorySearchView?

    var gitHubRepositoriesCount: Int {
        return gitHubRepositories.count
    }

    private let gitHubRepositorySearchUsecase: GitHubReposiotySearchUsecase
    private var gitHubRepositories: [GitHubRepository] = []

    private var searchTask: Task<Void, Error>?

    // MARK: - Initializer

    init(view: GitHubRepositorySearchView, gitHubRepositorySearchUsecase: GitHubReposiotySearchUsecase) {
        self.view = view
        self.gitHubRepositorySearchUsecase = gitHubRepositorySearchUsecase
    }

    // MARK: - Lifecycle

    func viewDidLoad() {
    }

    func viewWillAppear() {
    }

    func viewDidAppear() {
    }

    func viewDidStop() {
    }

    func gitHubRepository(at index: Int) -> GitHubRepository {
        return gitHubRepositories[index]
    }

    func tableViewDidSelectRow(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.pushToDetailView(gitHubRepository: self.gitHubRepositories[index])
        }
    }

    func searchBarSearchButtonDidTap(searchText: String) {
        searchTask = Task {
            do {
                self.gitHubRepositories = try await gitHubRepositorySearchUsecase.searchGitHubRepositories(by: searchText)

                DispatchQueue.main.async {
                    self.view?.tableViewReloadData()
                }
            } catch {
                Logger.error(error)
            }
        }
    }

    func searchBarSearchTextDidChange() {
        searchTask?.cancel()
    }
}
