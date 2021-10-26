//
//  GitHubRepositorySearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final class RepositorySearchPresenter: RepositorySearchPresentation {

    // MARK: - Property

    private weak var view: RepositorySearchView?

    var showEmptyView = false

    var gitHubRepositoriesCount: Int {
        return gitHubRepositories.count
    }

    private let gitHubRepositorySearchUsecase: GitHubReposiotySearchUsecase
    private var gitHubRepositories: [GitHubRepository] = []

    // 非検索状態で表示される「おすすめ」的な立ち位置のリポジトリ一覧
    private var initialGitHubRepositories: [GitHubRepository]?

    private var searchTask: Task<Void, Error>?

    // MARK: - Initializer

    init(view: RepositorySearchView, gitHubRepositorySearchUsecase: GitHubReposiotySearchUsecase) {
        self.view = view
        self.gitHubRepositorySearchUsecase = gitHubRepositorySearchUsecase
    }

    // MARK: - Lifecycle

    func viewDidLoad() {
        setInitialGitHubRepositories()
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
        DispatchQueue.main.async { [weak self] in
            self?.view?.startTableViewLoading()
        }

        searchTask = Task {
            do {
                self.gitHubRepositories = try await gitHubRepositorySearchUsecase.searchGitHubRepositories(by: searchText)
                showEmptyView = self.gitHubRepositories.isEmpty

                DispatchQueue.main.async { [weak self] in
                    self?.view?.stopTableViewLoading()
                    self?.view?.tableViewReloadData()
                    self?.view?.tableViewScrollToTop(animated: false)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.stopTableViewLoading()
                }
                Logger.error(error)
            }
        }
    }

    func searchBarCancelButtonDidTap() {
        searchTask?.cancel()
        setInitialGitHubRepositories()
    }

    func searchBarSearchTextDidChange() {
        searchTask?.cancel()
        DispatchQueue.main.async { [weak self] in
            self?.view?.stopTableViewLoading()
        }
    }

    // MARK: - Private

    private func setInitialGitHubRepositories() {
        // 既に取得してある場合は使い回す
        if let initialGitHubRepositories = initialGitHubRepositories {
            gitHubRepositories = initialGitHubRepositories
            showEmptyView = gitHubRepositories.isEmpty
            DispatchQueue.main.async { [weak self] in
                self?.view?.tableViewReloadData()
                self?.view?.tableViewScrollToTop(animated: false)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.view?.startTableViewLoading()
            }

            searchTask = Task {
                do {
                    let initialGitHubRepositories = try await gitHubRepositorySearchUsecase.getTrendingGitHubRepositories()
                    self.initialGitHubRepositories = initialGitHubRepositories
                    gitHubRepositories = initialGitHubRepositories
                    showEmptyView = gitHubRepositories.isEmpty

                    DispatchQueue.main.async { [weak self] in
                        self?.view?.stopTableViewLoading()
                        self?.view?.tableViewReloadData()
                        self?.view?.tableViewScrollToTop(animated: false)
                    }
                } catch {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.stopTableViewLoading()
                    }
                    Logger.error(error)
                }
            }
        }
    }
}
