//
//  RootViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/23.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, Storyboardable {

    // MARK: - Property

    private(set) var currentViewController: UIViewController?

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Public

    func route(_ viewController: UIViewController, animated: Bool, completion: ((UIViewController) -> Void)? = nil) {
        guard let currentViewController = currentViewController else {
            addChild(viewController)
            view.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            self.currentViewController = viewController

            return
        }

        transition(from: currentViewController, to: viewController, animated: animated)
        self.currentViewController = viewController
        completion?(viewController)
    }

    // MARK: - Private

    private func transition(from fromViewController: UIViewController, to toViewController: UIViewController, animated: Bool) {
        fromViewController.willMove(toParent: nil)
        addChild(toViewController)
        toViewController.view.alpha = 0

        let duration = animated ? 0.2 : 0

        transition(from: fromViewController, to: toViewController, duration: duration, options: [], animations: {
            toViewController.view.alpha = 1
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            fromViewController.removeFromParent()
            toViewController.didMove(toParent: self)
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}

