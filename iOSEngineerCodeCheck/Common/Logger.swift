//
//  Logger.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import SwiftyBeaver

public typealias Logger = SwiftyBeaver

public extension Logger {

    static func setup() {
        let destination = ConsoleDestination()
        SwiftyBeaver.addDestination(destination)
    }
}

