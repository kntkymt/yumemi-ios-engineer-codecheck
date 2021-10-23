//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    // MARK: - Property
    
    var repositorySearchViewController: RepositorySearchViewController!

    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        guard let searchTargetIndex = repositorySearchViewController.searchTargetIndex else { return }
        let repository = repositorySearchViewController.repositories[searchTargetIndex]

        titleLabel.text = repository["full_name"] as? String
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"

        if let owner = repository["owner"] as? [String: Any] {
            if let imageURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, _, _) in
                    let image = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }.resume()
            }
        }
    }
}
