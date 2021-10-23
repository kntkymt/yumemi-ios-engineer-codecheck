//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubRepositoryDetailViewController: UIViewController, Storyboardable {

    // MARK: - Outlet
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    // MARK: - Property
    
    var repository: [String: Any]!

    // MARK: - Build

    static func build(repository: [String: Any]) -> Self {
        let viewController = initViewController()
        viewController.repository = repository

        return viewController
    }

    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        titleLabel.text = repository["full_name"] as? String ?? ""
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"

        if let owner = repository["owner"] as? [String: Any],
           let imageURLString = owner["avatar_url"] as? String,
           let imageURL = URL(string: imageURLString) {

            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
                guard let self = self else { return }
                guard let data = data, let image = UIImage(data: data) else {
                    // TODO: エラーハンドリング
                    print(error)
                    return
                }

                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }.resume()
        }
    }
}
