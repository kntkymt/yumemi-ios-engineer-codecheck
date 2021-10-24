//
//  SplashViewProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//


protocol SplashView: AnyObject {
    /// main画面に遷移する
    func routeToMain()
}

protocol SplashPresentation: Presentation {
}
