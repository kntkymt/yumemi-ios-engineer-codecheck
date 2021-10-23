//
//  SceneDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Property

    var window: UIWindow?

    // MARK: - Lifecycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        SceneRouter.shared.rootViewController = window?.rootViewController as? RootViewController
        SceneRouter.shared.route(to: .splash, animated: true)
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
