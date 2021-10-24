//
//  GitHubRepositorySearchProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol GitHubRepositorySearchView: AnyObject {

    /// TableViewをリロードする
    func tableViewReloadData()

    /// 詳細画面に遷移する
    ///
    /// - parameters:
    ///     - repository: 詳細を表示するGitHubのリポジトリ
    func pushToDetailView(gitHubRepository: GitHubRepository)
}

protocol GitHubRepositorySearchPresentation: Presentation {

    /// GitHubのリポジトリの数
    var gitHubRepositoriesCount: Int { get }

    /// 指定されたindexのGitHubRepositoryを返す
    ///
    /// - parameters:
    ///     - index: 指定するindex
    /// - Returns: 指定されたGitHubRepository
    func gitHubRepository(at index: Int) -> GitHubRepository

    /// TableViewがselectされた
    ///
    /// - parameters:
    ///     - index: selectされたindex
    func tableViewDidSelectRow(at index: Int)

    /// 検索ボタンが押された
    ///
    /// - parameters:
    ///     - searchText: 検索語
    func searchBarSearchButtonDidTap(searchText: String)

    /// 検索文字が変更された
    func searchBarSearchTextDidChange()
}

