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
    
    var gitHubRepository: GitHubRepository!

    // MARK: - Build

    static func build(gitHubRepository: GitHubRepository) -> Self {
        let viewController = initViewController()
        viewController.gitHubRepository = gitHubRepository

        return viewController
    }

    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        titleLabel.text = gitHubRepository.fullName
        languageLabel.text = "Written in \(gitHubRepository.language)"
        starLabel.text = "\(gitHubRepository.stargazersCount) stars"
        watchersLabel.text = "\(gitHubRepository.watchersCount) watchers"
        forksLabel.text = "\(gitHubRepository.forksCount) forks"
        issuesLabel.text = "\(gitHubRepository.openIssuesCount) open issues"

        URLSession.shared.dataTask(with: gitHubRepository.owner.avatarUrl) { [weak self] (data, _, error) in
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
