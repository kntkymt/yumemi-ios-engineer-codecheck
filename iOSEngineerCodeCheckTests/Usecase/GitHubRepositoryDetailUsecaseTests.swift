//
//  GitHubRepositoryDetailUsecaseTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitHubRepositoryDetailUsecaseTests: XCTestCase {

    // MARK: - Property

    private let usecase: GitHubRepositoryDetailUsecase = GitHubRepositoryDetailUsecaseImpl(gitHubRepositoryReadmeRepository: GitHubRepositoryReadmeRepositoryImpl())

    // MARK: - Lifecycle

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createService())
    }

    // MARK: - Test

    func testGetGitHubRepositoryReadme() {
        let expectation = expectation(description: "GetGitHubRepositoryReadme")

        Task {
            do {
                let response = try await usecase.getGitHubRepositoryReadme(repository: "swift", owner: "apple")

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError(error)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

final class GitHubRepositoryDetailUsecaseWithStubTests: XCTestCase {

    // MARK: - Property

    private let usecase: GitHubRepositoryDetailUsecase = GitHubRepositoryDetailUsecaseImpl(gitHubRepositoryReadmeRepository: GitHubRepositoryReadmeRepositoryStubImpl())

    // MARK: - Test

    func testGetGitHubRepositoryReadme() {
        let expectation = expectation(description: "GetGitHubRepositoryReadme")

        Task {
            do {
                let response = try await usecase.getGitHubRepositoryReadme(repository: "swift", owner: "apple")

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError(error)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

