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

        title = "検索"
    }

    // MARK: - UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.gitHubRepositoriesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath)
        let gitHubRepository = presenter.gitHubRepository(at: indexPath.row)

        cell.textLabel?.text = gitHubRepository.fullName
        cell.detailTextLabel?.text = gitHubRepository.language
        cell.tag = indexPath.row

        return cell
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
        let detailViewController = GitHubRepositoryDetailViewController.build(gitHubRepository: gitHubRepository)
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
