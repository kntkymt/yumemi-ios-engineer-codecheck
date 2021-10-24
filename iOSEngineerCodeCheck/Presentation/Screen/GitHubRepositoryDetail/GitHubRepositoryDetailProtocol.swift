//
//  GitHubRepositoryDetailProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubRepositoryDetailView: AnyObject {

    /// GitHubのリポジトリ詳細を表示する
    ///
    /// - parameters:
    ///     - gitHubRepository: GitHubのリポジトリ
    func showGitHubRepositoryDetail(gitHubRepository: GitHubRepository)
}

protocol GitHubRepositoryDetailPresentation: Presentation {
}
