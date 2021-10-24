//
//  SplashPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final class SplashPresenter: SplashPresentation {

    // MARK: - Property

    private weak var view: SplashView?

    // MARK: - Initializer

    init(view: SplashView) {
        self.view = view
    }

    // MARK: - Lifecycle

    func viewDidLoad() {
    }

    func viewWillAppear() {
    }

    // viewDidAppearでしか遷移しない
    func viewDidAppear() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.routeToMain()
        }
    }

    func viewDidStop() {
    }
}
