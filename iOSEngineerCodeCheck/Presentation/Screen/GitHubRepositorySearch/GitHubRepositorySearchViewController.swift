//
//  GitHubRepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubRepositorySearchViewController: UITableViewController, Storyboardable {

    // MARK: - Outlet

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
            searchBar.delegate = self
        }
    }

    // MARK: - Property

    var presenter: GitHubRepositorySearchPresentation!

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(GitHubRepositoryTableViewCell.self)
        title = "検索"
        
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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

        return tableView.dequeue(GitHubRepositoryTableViewCell.self, for: indexPath, with: gitHubRepository)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tableViewDidSelectRow(at: indexPath.row)
    }
}

// MARK: - GitHubRepositorySearchView

extension GitHubRepositorySearchViewController: GitHubRepositorySearchView {

    func tableViewReloadData() {
        self.tableView.reloadData()
    }
    
    func pushToDetailView(gitHubRepository: GitHubRepository) {
        let detailHeadingViewController = GitHubRepositoryDetailHeadingViewController.build()
        detailHeadingViewController.presenter = GitHubRepositoryDetailHeadingPresenter(view: detailHeadingViewController, gitHubRepository: gitHubRepository)

        let detailCountViewController = GitHubRepositoryDetailCountViewController.build()
        detailCountViewController.presenter = GitHubRepositoryDetailCountPresenter(view: detailCountViewController, gitHubRepository: gitHubRepository)
        
        let detailViewController = GitHubRepositoryDetailViewController.build(headingViewController: detailHeadingViewController,
                                                                              countViewController: detailCountViewController)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension GitHubRepositorySearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarSearchTextDidChange()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarSearchButtonDidTap(searchText: searchBar.text ?? "")
    }
}
