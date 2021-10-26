//
//  GitHubRepositoryDetailCountProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol RepositoryDetailCountView: AnyObject {

    /// GitHubのリポジトリ詳細を表示する
    ///
    /// - parameters:
    ///     - gitHubRepository: GitHubのリポジトリ
    func showGitHubRepositoryDetailCount(gitHubRepository: GitHubRepository)
}

protocol RepositoryDetailCountPresentation: Presentation {
}
