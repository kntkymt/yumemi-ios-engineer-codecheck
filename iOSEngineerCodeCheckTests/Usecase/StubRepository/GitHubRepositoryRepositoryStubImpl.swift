//
//  GitHubRepositoryStubRepositoryImpl.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

final class GitHubRepositoryRepositoryStubImpl: GitHubRepositoryRepository {

    // MARK: - Property

    private let gitHubRepository = GitHubRepository(
        fullName: "kntkymt/kntkymt",
        name: "kntkymt",
        htmlUrl: URL(string: "https://github.com/kntkymt/kntkymt")!,
        language: "Swift",
        description: nil,
        owner: User(login: "kntkymt", avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/44288050?s=400&u=57fbf71e9e2e411af3da17f82051cf83cdb0df56&v=4")!),
        stargazersCount: 10,
        watchersCount: 10,
        forksCount: 15,
        openIssuesCount: 2
    )

    // MARK: - Internal

    func searchGitHubRepositories(by word: String, sort: GitHubRepositorySortKind) async throws -> [GitHubRepository] {
        return .init(repeating: gitHubRepository, count: 10)
    }
}
