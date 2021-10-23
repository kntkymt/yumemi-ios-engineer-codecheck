//
//  GitHubRepositoryRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol GitHubRepositoryRepository {

    func searchGitHubRepositories(by word: String) async throws -> [GitHubRepository]
}


final class GitHubRepositoryRepositoryImpl: GitHubRepositoryRepository {

    func searchGitHubRepositories(by word: String) async throws -> [GitHubRepository] {
        return try await API.shared.call(SearchGitHubRepositoryRequest(query: word)).items
    }
}
