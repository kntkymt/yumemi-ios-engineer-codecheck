//
//  RepositorySearchProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol RepositorySearchView: AnyObject, BannerShowable {

    /// TablewViewのロード表示をする
    func showTableViewLoading()

    /// TableViewのロード表示を隠す
    func hideTableViewLoading()

    /// TableViewを最上部までスクロールする
    ///
    /// - parameters:
    ///     - animated: アニメーションをするかどうか
    func tableViewScrollToTop(animated: Bool)

    /// TableViewをリロードする
    func tableViewReloadData()

    /// 詳細画面に遷移する
    ///
    /// - parameters:
    ///     - repository: 詳細を表示するGitHubのリポジトリ
    func pushToDetailView(gitHubRepository: GitHubRepository)
}

protocol RepositorySearchPresentation: Presentation {

    /// ErrorViewを表示するかどうか
    var showErrorView: Bool { get }

    /// EmptyViewを表示するかどうか
    var showEmptyView: Bool { get }

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
    func searchBarSearchButtonDidTap()

    /// キャンセルボタンが押された
    func searchBarCancelButtonDidTap()

    /// 検索文字が変更された
    /// 
    /// - parameters:
    ///     - searchText: 検索語
    func searchBarSearchTextDidChange(searchText: String)

    /// ErroViewのリフレッシュボタンが押された
    func errorViewRefreshButtonDidTap()
}

