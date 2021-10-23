//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositorySearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [[String: Any]] = []
    
    var searchAPITask: URLSessionTask?
    var searchWord: String!
    var searchAPIURL: String!
    var searchTargetIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
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
        
        if searchWord.count != 0 {
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! RepositoryDetailViewController
            dtl.vc1 = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repositories[indexPath.row]

        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTargetIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
