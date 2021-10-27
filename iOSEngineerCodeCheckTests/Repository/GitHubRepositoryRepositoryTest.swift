//
//  GitHubRepositoryRepositoryTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitHubRepositoryRepositoryTests: XCTestCase {

    // MARK: - Property

    private let gitHubRepositoryRepository = GitHubRepositoryRepositoryImpl()

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
                let response = try await gitHubRepositoryRepository.searchGitHubRepositories(by: "Swift", sort: .bestMatch)

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

final class GitHubRepositoryRepositoryWithStubTests: XCTestCase {

    // MARK: - Property

    private let gitHubRepositoryRepository = GitHubRepositoryRepositoryImpl()

    // MARK: - Lifecycle

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createStub())
    }

    // MARK: - Test

    func testSearchGitHubRepositories() {
        let expectation = expectation(description: "SearchGitHubRepositories")

        Task {
            do {
                let response = try await gitHubRepositoryRepository.searchGitHubRepositories(by: "Swift", sort: .bestMatch)

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
