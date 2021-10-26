//
//  Presentation.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol Presentation: AnyObject {

    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewDidStop()
}
