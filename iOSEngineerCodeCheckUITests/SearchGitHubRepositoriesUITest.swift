//
//  SearchGitHubRepositoryUITest.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by kntk on 2021/10/28.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class SearchGitHubRepositoriesUITests: XCTestCase {

    // MARK: - Property

    private var app: XCUIApplication!

    // MARK: - Lifecycle

    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }

    // MARK: - Test

    func testSearchRepositories() {
        // 初回表示が終わるまで待つ
        _ = app.waitForExistence(timeout: 5)

        // 検索
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Alamofire")
        app.buttons["search"].tap()

        // 検索ボタンを押した直後は初回表示のセルが残っているので少し待つ
        _ = app.waitForExistence(timeout: 2)

        // 検索結果が10秒以内に表示される
        XCTContext.runActivity(named: "show search results in 10 seconds") { _ in
            let initialItemCell = app.tables.firstMatch.children(matching: .cell).firstMatch.waitForExistence(timeout: 10)

            XCTAssertNotNil(initialItemCell)
        }
    }
}

