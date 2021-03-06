//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositorySearchViewController: UITableViewController, Storyboardable {

    // MARK: - Property

    var presenter: RepositorySearchPresentation!

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "GitHubのリポジトリを検索"

        return searchController
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.color = .systemGray
        indicatorView.backgroundColor = .clear
        indicatorView.frame.size.height = 50
        indicatorView.hidesWhenStopped = true

        return indicatorView
    }()

    private lazy var emptyViewController = EmptyViewController.build(emptyTitle: "リポジトリがありません")
    private lazy var errorViewController = ErrorViewController.build(refreshTitle: "再読み込み", hideRefreshButton: false)

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.addSubview(indicatorView, constraints: .center())

        tableView.register(RepositoryTableViewCell.self)

        title = "検索"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        errorViewController.setRefreshButtonHandler { [weak self] in
            self?.presenter.errorViewRefreshButtonDidTap()
        }
        
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true

        presenter.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    deinit {
        presenter.viewDidStop()
    }

    // MARK: - UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.gitHubRepositoriesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gitHubRepository = presenter.gitHubRepository(at: indexPath.row)

        return tableView.dequeue(RepositoryTableViewCell.self, for: indexPath, with: gitHubRepository)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if presenter.showErrorView {
            return errorViewController.view
        } else if presenter.showEmptyView {
            return emptyViewController.view
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tableViewDidSelectRow(at: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter.showEmptyView || presenter.showErrorView ? tableView.bounds.height : CGFloat.leastNormalMagnitude
    }
}

// MARK: - RepositorySearchView

extension RepositorySearchViewController: RepositorySearchView {

    func showTableViewLoading() {
        indicatorView.startAnimating()
        tableView.isUserInteractionEnabled = false
    }

    func hideTableViewLoading() {
        indicatorView.stopAnimating()
        tableView.isUserInteractionEnabled = true
    }

    func tableViewScrollToTop(animated: Bool) {
        if tableView.numberOfRows(inSection: 0) != 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
        }
    }

    func tableViewReloadData() {
        self.tableView.reloadData()
    }
    
    func pushToDetailView(gitHubRepository: GitHubRepository) {
        let detailHeadingViewController = RepositoryDetailHeadingViewController.build()
        detailHeadingViewController.presenter = GitHubRepositoryDetailHeadingPresenter(view: detailHeadingViewController, gitHubRepository: gitHubRepository)

        let detailCountViewController = RepositoryDetailCountViewController.build()
        detailCountViewController.presenter = RepositoryDetailCountPresenter(view: detailCountViewController, gitHubRepository: gitHubRepository)

        let detailReadMeViewController = RepositoryDetailReadmeViewController.build()
        detailReadMeViewController.presenter = RepositoryDetailReadMePresenter(view: detailReadMeViewController, gitHubRepositoryDetailUsecase: AppContainer.shared.gitHubRepositoryDetailUsecase, gitHubRepository: gitHubRepository)
        
        let detailViewController = RepositoryDetailViewController.build(headingViewController: detailHeadingViewController,
                                                                              countViewController: detailCountViewController,
                                                                              readMeViewController: detailReadMeViewController, gitHubRepository: gitHubRepository)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension RepositorySearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarSearchTextDidChange(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarSearchButtonDidTap()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancelButtonDidTap()
    }
}
