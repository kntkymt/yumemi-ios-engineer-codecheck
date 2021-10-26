//
//  GitHubRepositoryDetailUsecase.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//


protocol GitHubRepositoryDetailUsecase {

    func getGitHubRepositoryReadme(repository: String, owner: String) async throws -> String
}

final class GitHubRepositoryDetailUsecaseImpl: GitHubRepositoryDetailUsecase {

    // MARK: - Property

    private let gitHubRepositoryReadmeRepository: GitHubRepositoryReadmeRepository

    // MARK: - Initializer

    init(gitHubRepositoryReadmeRepository: GitHubRepositoryReadmeRepository) {
        self.gitHubRepositoryReadmeRepository = gitHubRepositoryReadmeRepository
    }

    // MARK: - Internal

    func getGitHubRepositoryReadme(repository: String, owner: String) async throws -> String {
        return try await gitHubRepositoryReadmeRepository.getGitHubRepositoryReadme(repository: repository, owner: owner)
    }
}
