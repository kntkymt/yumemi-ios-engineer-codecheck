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

    // 通常の検索のテスト
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
        let initialItemCell = app.tables.firstMatch.children(matching: .cell).firstMatch.waitForExistence(timeout: 10)
        XCTAssertTrue(initialItemCell)
    }

    // 検索結果が空だった場合のテスト
    func testWhenSearchResultIsEmpty() {
        // 初回表示が終わるまで待つ
        _ = app.waitForExistence(timeout: 5)

        // 検索結果が空になる文字を打つ
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("あeueｗぃえ")
        app.buttons["search"].tap()

        // 検索ボタンを押した直後は初回表示のセルが残っているので少し待つ
        _ = app.waitForExistence(timeout: 2)

        let emptyViewTitle = app.tables.staticTexts.firstMatch.label
        XCTAssertEqual(emptyViewTitle, "リポジトリがありません")
    }

    // 検索結果がエラーだった場合のテスト
    func testWhenSearchResultIsError() {
        // 初回表示が終わるまで待つ
        _ = app.waitForExistence(timeout: 5)

        // 検索結果がエラーになる文字を打つ
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("    ")
        app.buttons["search"].tap()

        // 検索ボタンを押した直後は初回表示のセルが残っているので少し待つ
        _ = app.waitForExistence(timeout: 2)

        let errorViewTitle = app.tables.staticTexts.firstMatch.label
        XCTAssertEqual(errorViewTitle, "再読み込み")
    }
}

