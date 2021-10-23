//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositorySearchViewController: UITableViewController {

    // MARK: - Outlet

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
            searchBar.delegate = self
        }
    }

    // MARK: - Property
    
    private(set) var repositories: [[String: Any]] = []
    private(set) var searchTargetIndex: Int!

    private var searchWord: String!
    private var searchAPITask: URLSessionTask?
    private var searchAPIURL: String!

    // MARK: - Lifecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! RepositoryDetailViewController
            dtl.vc1 = self
        }
    }

    // MARK: - Private

    private func searchRepositories() {
        searchAPIURL = "https://api.github.com/search/repositories?q=\(searchWord!)"
        searchAPITask = URLSession.shared.dataTask(with: URL(string: searchAPIURL)!) { (data, res, err) in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                if let items = obj["items"] as? [[String: Any]] {
                    self.repositories = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }

        searchAPITask?.resume()
    }

    // MARK: - UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath)
        let repository = repositories[indexPath.row]

        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTargetIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

// MARK: - UISearchBarDelegate

extension RepositorySearchViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 入力を開始したら既存の検索語を削除する
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchAPITask?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWord = searchBar.text!
        if searchWord.isEmpty { return }

        searchRepositories()
    }
}
