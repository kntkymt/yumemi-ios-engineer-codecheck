//
//  SearchGitHubRepositoryUsecase.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol SearchGitHubReposiotyUsecase {

    func searchGitHubRepositories(by word: String) async throws -> [GitHubRepository]
}

final class SearchGitHubRepositoryUsecaseImpl: SearchGitHubReposiotyUsecase {

    // MARK: - Property

    private let gitHubRepositoryRepository: GitHubRepositoryRepository

    // MARK: - Initializer

    init(gitHubRepositoryRepository: GitHubRepositoryRepository) {
        self.gitHubRepositoryRepository = gitHubRepositoryRepository
    }

    // MARK: - Internal

    func searchGitHubRepositories(by word: String) async throws -> [GitHubRepository] {
        return try await gitHubRepositoryRepository.searchGitHubRepositories(by: word)
    }
}
