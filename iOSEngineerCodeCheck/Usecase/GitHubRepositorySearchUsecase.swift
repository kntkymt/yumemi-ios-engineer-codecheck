//
//  GitHubRepositorySearchUsecase.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol GitHubReposiotySearchUsecase {

    func searchGitHubRepositories(by word: String) async throws -> [GitHubRepository]

    func getTrendingGitHubRepositories() async throws -> [GitHubRepository]
}

final class GitHubRepositorySearchUsecaseImpl: GitHubReposiotySearchUsecase {

    // MARK: - Property

    private let gitHubRepositoryRepository: GitHubRepositoryRepository

    // MARK: - Initializer

    init(gitHubRepositoryRepository: GitHubRepositoryRepository) {
        self.gitHubRepositoryRepository = gitHubRepositoryRepository
    }

    // MARK: - Internal

    func searchGitHubRepositories(by word: String) async throws -> [GitHubRepository] {
        return try await gitHubRepositoryRepository.searchGitHubRepositories(by: word, sort: .bestMatch)
    }

    // FIXME: トレンドAPI
    // トレンド的な良さげなレポジトリを返してくれるAPIがほしかったが、
    // なかったので現状はSwiftで検索したもので代用中
    func getTrendingGitHubRepositories() async throws -> [GitHubRepository] {
        return try await gitHubRepositoryRepository.searchGitHubRepositories(by: "Swift", sort: .stars)
    }
}
