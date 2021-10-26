//
//  GitHubRepositoryDetailProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubRepositoryDetailHeadingView: AnyObject {

    /// GitHubのリポジトリ詳細を表示する
    ///
    /// - parameters:
    ///     - gitHubRepository: GitHubのリポジトリ
    func showGitHubRepositoryDetailHeading(gitHubRepository: GitHubRepository)
}

protocol GitHubRepositoryDetailHeadingPresentation: Presentation {
}
