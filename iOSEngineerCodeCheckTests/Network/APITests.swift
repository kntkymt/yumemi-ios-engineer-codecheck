//
//  APITests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class APITests: XCTestCase {

    override class func setUp() {
        super.setUp()

        API.setup(provider: APIProviderFactory.createService())
    }

    func testSearchGitHubRepositoryRequest() {
        let expectation = expectation(description: "SearchGitHubRepositoryRequest")

        Task {
            do {
                let response = try await API.shared.call(SearchGitHubRepositoryRequest(query: "Swift", sort: .bestMatch))

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testGetGitHubRepotitoryReadmeRequest() {
        let expectation = expectation(description: "GetGitHubRepotitoryReadmeRequest")

        Task {
            do {
                let response = try await API.shared.call(GetGitHubRepositoryReadmeRequest(owner: "apple", repository: "swift"))

                XCTAssertNotNil(response)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 2.0)
    }
}
