//
//  GitHubRepositoryRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol GitHubRepositoryRepository {

    /// 指定された検索語でGitHubのリポジトリを検索する
    ///
    /// - parameters:
    ///     - word: 検索語
    ///     - sort: 検索結果のソート方法
    /// - returns: 検索結果
    func searchGitHubRepositories(by word: String, sort: GitHubRepositorySortKind) async throws -> [GitHubRepository]
}


final class GitHubRepositoryRepositoryImpl: GitHubRepositoryRepository {

    func searchGitHubRepositories(by word: String, sort: GitHubRepositorySortKind) async throws -> [GitHubRepository] {
        return try await API.shared.call(SearchGitHubRepositoryRequest(query: word, sort: sort)).items
    }
}
