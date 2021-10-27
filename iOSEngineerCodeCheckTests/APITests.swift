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
        Task {
            do {
                let response = try await API.shared.call(SearchGitHubRepositoryRequest(query: "Swift", sort: .bestMatch))

                XCTAssertNotNil(response)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testGetGitHubRepotitoryReadmeRequest() {
        Task {
            do {
                let response = try await API.shared.call(GetGitHubRepositoryReadmeRequest(owner: "apple", repository: "swift"))

                XCTAssertNotNil(response)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
