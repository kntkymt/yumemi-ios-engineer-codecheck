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
            cardView.layer.shadowRadius = 16
            cardView.layer.shadowOpacity = 1.0
            cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
            cardView.layer.shadowColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1)
        }
    }
    @IBOutlet private weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 14
            iconImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!

}

// MARK: - NibInstantiatable

extension GitHubRepositoryTableViewCell: NibInstantiatable {

    typealias Dependency = GitHubRepository

    func inject(_ dependency: GitHubRepository) {
        iconImageView.load(dependency.owner.avatarUrl, contentMode: .scaleToFill)
        ownerNameLabel.text = dependency.owner.login
        repositoryNameLabel.text = dependency.name
        repositoryDescriptionLabel.text = dependency.description
    }
}
