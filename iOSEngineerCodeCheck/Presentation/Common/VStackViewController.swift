//
//  VStackViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//
// base: https://github.com/d-date/IntegrateAppExample/blob/master/IntegrateAppExample/Scenes/Stacks/VStackViewController.swift

import UIKit

public class VStackViewController: UIViewController {

    // MARK: - Property
    
    let scrollView: UIScrollView = .init()
    let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0

        return stackView
    }()
    lazy var bottomConstraint = view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

    var components: [UIViewController]!

    // MARK: - Override

    override public func viewDidLoad() {
        super.viewDidLoad()

        components.forEach { [weak self] in self?.addChild($0) }

        view.addSubview(scrollView, constraints: .allEdges())
        scrollView.addSubview(stackView, constraints: .allEdges() + [equal(\.widthAnchor)])

        components.forEach { [weak self] in
            guard let self = self else { return }
            self.stackView.addArrangedSubview($0.view)
        }
        components.forEach { [weak self] in
            guard let self = self else { return }
            $0.didMove(toParent: self)
        }
    }
}

