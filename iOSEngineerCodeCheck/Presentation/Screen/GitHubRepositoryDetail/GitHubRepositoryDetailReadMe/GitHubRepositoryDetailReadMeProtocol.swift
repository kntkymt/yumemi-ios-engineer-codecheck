//
//  GitHubRepositoryDetailReadMeProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol GitHubRepositoryDetailReadMeView: AnyObject {

    /// readmeを表示する
    ///
    /// - parameters:
    ///     - content: マークダウン形式のreadme
    func showReadme(_ content: String)

    /// readmeViewControllerを隠す
    func hideReadmeViewController()
}

protocol GitHubRepositoryDetailReadMePresentation: Presentation {

    /// WebViewのセットアップが終了した
    func webViewDidFinishSetup()
}

