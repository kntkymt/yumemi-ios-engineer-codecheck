//
//  ShowGitHubRepositoryDetailUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class ShowGitHubRepositoryDetailUITests: XCTestCase {

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

    func testShowGitHubRepositoryDetail() {
        // 初期表示リポジトリが10秒以内に表示される
        XCTContext.runActivity(named: "show initial items in 10 seconds") { _ in
            let initialItemCell = app.tables.element(boundBy: 0).children(matching: .cell).element(boundBy: 0)

            let exists = NSPredicate(format: "exists == true")
            expectation(for: exists, evaluatedWith: initialItemCell, handler: nil)
            waitForExpectations(timeout: 10, handler: nil)
        }

        // 詳細へ正常へ遷移できる
        XCTContext.runActivity(named: "push to Detail View") { _ in
            let initialItemCell = app.tables.element(boundBy: 0).children(matching: .cell).element(boundBy: 0)
            initialItemCell.tap()

            // ImageViewが存在することを確認
            XCTAssert(app.images.element(boundBy: 0).exists)
        }

        // Readmeが10秒以内に表示される
        // FIXME: リポジトリによっては失敗することがある
        XCTContext.runActivity(named: "show readme in 10 seconds") { _ in
            // 一番下までスクロール
            app.swipeUp(velocity: 1000)

            let webView = app.webViews.element(boundBy: 0)
            // リンク, 画像, 文字等々何らかがWebView内に表示できていることを確認する
            let link = webView.links.firstMatch
            let image = webView.images.firstMatch
            let staticText = webView.staticTexts.firstMatch
            let textField = webView.textViews.firstMatch

            let exists = NSPredicate(format: "%@.exists == true OR %@.exists == true OR %@.exists == true OR %@.exists == true", link, image, staticText, textField)
            expectation(for: exists, evaluatedWith: nil, handler: nil)

            waitForExpectations(timeout: 10, handler: nil)
        }
    }
}
