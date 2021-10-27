//
//  RepositoryDetailReadMeProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepositoryDetailReadmeView: AnyObject, WebViewShowable, BannerShowable {

    /// WebViewをセットアップする
    /// 
    /// - parameters:
    ///     - url: 初期読み込みのurl
    func setupWebView(url: URL)

    /// webView.evaluateJavaScriptを実行する
    ///
    /// - parameters:
    ///     - javaScript: 実行対象JSの文字列
    func evaluateJavaScriptToWebView(javaScript: String)

    /// readmeViewControllerを隠す
    func hideReadmeViewController()

    /// ErrorViewを表示する
    func showErrorView()

    /// ErrorViewを非表示にする
    func hideErrorView()
}

protocol RepositoryDetailReadmePresentation: Presentation {

    /// WebViewのセットアップが終了した
    func webViewDidFinishSetup()

    /// WebViewがJavaScriptの実行に失敗した
    ///
    /// - parameters:
    ///     - error: 原因のエラー
    func webViewDidFailEvaluateJavaScript(with error: Error)

    /// WebViewがURLの読み込みをして良いかどうか
    ///
    /// - parameters:
    ///     - url: 読み込みURL
    /// - returns: 読み込みをして良いかどうか
    func webViewCanNavigate(to url: URL) -> Bool

    /// ErroViewのリフレッシュボタンが押された
    func errorViewRefreshButtonDidTap()
}

