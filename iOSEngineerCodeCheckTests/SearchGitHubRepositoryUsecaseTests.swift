//
//  SearchGitHubRepositoryUsecaseTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//


import XCTest
@testable import iOSEngineerCodeCheck

final class SearchGitHubRepositoryUsecaseTests: XCTestCase {

    // MARK: - Property

    private let usecase: GitHubReposiotySearchUsecase = GitHubRepositorySearchUsecaseImpl(gitHubRepositoryRepository: GitHubRepositoryRepositoryImpl())

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createService())
    }

    func testGetGitHubRepository() {
        Task {
            do {
                let repositories = try await usecase.searchGitHubRepositories(by: "kntkymt")

                XCTAssertFalse(repositories.isEmpty)
            } catch {
                XCTAssertThrowsError(error)
            }
        }
    }
}
