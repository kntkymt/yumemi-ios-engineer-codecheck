//
//  GitHubRepositoryReadmeRepositoryTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitHubRepositoryReadmeRepositoryTests: XCTestCase {

    // MARK: - Property

    private let gitHubRepositoryReadmeRepository = GitHubRepositoryReadmeRepositoryImpl()

    // MARK: - Lifecycle

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createService())
    }

    // MARK: - Test

    func testGitHubRepositoryReadme() {
        let expectation = expectation(description: "getGitHubRepositoryReadme")

        Task {
            do {
                let response = try await gitHubRepositoryReadmeRepository.getGitHubRepositoryReadme(repository: "swift", owner: "apple")

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

final class GitHubRepositoryReadmeRepositoryWithStubTests: XCTestCase {

    // MARK: - Property

    private let gitHubRepositoryReadmeRepository = GitHubRepositoryReadmeRepositoryImpl()

    // MARK: - Lifecycle

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createStub())
    }

    // MARK: - Test

    func testGitHubRepositoryReadme() {
        let expectation = expectation(description: "getGitHubRepositoryReadme")

        Task {
            do {
                let response = try await gitHubRepositoryReadmeRepository.getGitHubRepositoryReadme(repository: "swift", owner: "apple")

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

