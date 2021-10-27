//
//  SearchGitHubRepositoryUsecaseTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitHubRepositorySearchUsecaseTests: XCTestCase {

    // MARK: - Property

    private let usecase: GitHubReposiotySearchUsecase = GitHubRepositorySearchUsecaseImpl(gitHubRepositoryRepository: GitHubRepositoryRepositoryImpl())

    // MARK: - Lifecycle

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createService())
    }

    // MARK: - Test

    func testSearchGitHubRepositories() {
        let expectation = expectation(description: "SearchGitHubRepositories")

        Task {
            do {
                let repositories = try await usecase.searchGitHubRepositories(by: "kntkymt")

                XCTAssertNotNil(repositories)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError(error)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testGetTrendingGitHubRepositories() {
        let expectation = expectation(description: "GetTrendingGitHubRepositories")

        Task {
            do {
                let repositories = try await usecase.getTrendingGitHubRepositories()

                XCTAssertNotNil(repositories)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError(error)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

final class GitHubRepositorySearchUsecaseWithStubTests: XCTestCase {

    // MARK: - Property

    private let usecase: GitHubReposiotySearchUsecase = GitHubRepositorySearchUsecaseImpl(gitHubRepositoryRepository: GitHubRepositoryRepositoryStubImpl())

    // MARK: - Test

    func testSearchGitHubRepositories() {
        let expectation = expectation(description: "SearchGitHubRepositories")

        Task {
            do {
                let response = try await usecase.searchGitHubRepositories(by: "kntkymt")

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError(error)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testGetTrendingGitHubRepositories() {
        let expectation = expectation(description: "GetTrendingGitHubRepositories")

        Task {
            do {
                let response = try await usecase.getTrendingGitHubRepositories()

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError(error)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
