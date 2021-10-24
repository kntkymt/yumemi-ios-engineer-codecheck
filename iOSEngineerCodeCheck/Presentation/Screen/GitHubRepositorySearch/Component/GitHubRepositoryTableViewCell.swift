//
//  GitHubRepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubRepositoryTableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet private weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 10
            cardView.layer.shadowRadius = 4
            cardView.layer.shadowOpacity = 1.0
            cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
            cardView.layer.shadowColor = UIColor.systemGray3.cgColor
        }
    }
    @IBOutlet private weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 14
            // 左上と右上の角のみ丸くする
            iconImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!

    @IBOutlet private weak var starCountLabel: UILabel!

    @IBOutlet private weak var languageIconImageView: UIImageView!
    @IBOutlet private weak var languageLabel: UILabel!
}

// MARK: - NibInstantiatable

extension GitHubRepositoryTableViewCell: NibInstantiatable {

    typealias Dependency = GitHubRepository

    func inject(_ dependency: GitHubRepository) {
        iconImageView.load(dependency.owner.avatarUrl, contentMode: .scaleToFill)
        ownerNameLabel.text = dependency.owner.login
        repositoryNameLabel.text = dependency.name
        repositoryDescriptionLabel.text = dependency.description
        starCountLabel.text = String.localizedStringWithFormat("%d", dependency.stargazersCount)
        if let language = dependency.language {
            languageIconImageView.isHidden = false
            languageLabel.text = language
        } else {
            languageIconImageView.isHidden = true
            languageLabel.text = ""
        }
    }
}
