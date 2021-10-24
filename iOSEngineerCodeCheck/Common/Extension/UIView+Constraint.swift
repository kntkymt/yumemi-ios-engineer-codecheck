//
//  UIView+Constraint.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//
// https://github.com/d-date/IntegrateAppExample/blob/master/IntegrateAppExample/Scenes/Common/UIView+Layout.swift

import UIKit

typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant, priority: priority)
}

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        let constraint = view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        return constraint
    }
}

func equal<L, Axis>(_ keyPath: KeyPath<UIView, L>, to other: NSLayoutAnchor<Axis>, constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, _ in
        let constraint = view[keyPath: keyPath].constraint(equalTo: other, constant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        return constraint
    }
}

func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat, priority: UILayoutPriority? = nil) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        let constraint = view1[keyPath: keyPath].constraint(equalToConstant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        return constraint
    }
}

extension Array where Element == Constraint {
    static func allEdges(margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> [Constraint] {
        return horizontalEdges(margin: margin, priority: priority) + verticalEdges(margin: margin, priority: priority)
    }

    static func horizontalEdges(margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> [Constraint] {
        return [equal(\.leadingAnchor, constant: margin, priority: priority), equal(\.trailingAnchor, constant: -margin, priority: priority)]
    }

    static func verticalEdges(margin: CGFloat = 0, priority: UILayoutPriority? = nil) -> [Constraint] {
        return [equal(\.topAnchor, constant: margin, priority: priority), equal(\.bottomAnchor, constant: -margin, priority: priority)]
    }

    static func center(priority: UILayoutPriority? = nil) -> [Constraint] {
        return [equal(\.centerXAnchor, priority: priority), equal(\.centerYAnchor, priority: priority)]
    }

    static func size(_ size: CGSize) -> [Constraint] {
        return [equal(\.widthAnchor, constant: size.width), equal(\.heightAnchor, constant: size.height)]
    }
}

extension UIView {
    func addSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }

    func update(_ subview: UIView, constraints: [Constraint]) {
        let newConstraints: [NSLayoutConstraint] = constraints.map { $0(subview, self) }
        let current = self.constraints
        newConstraints.forEach { newConstraint in
            if let constraint = current.first(where: {
                if let currentSecondAnchor = $0.secondAnchor,
                    let newSecondAnchor = newConstraint.secondAnchor {
                    return $0.firstAnchor == newConstraint.firstAnchor && newSecondAnchor == currentSecondAnchor
                } else {
                    return $0.firstAnchor == newConstraint.firstAnchor
                }
            }) {
                self.removeConstraint(constraint)
            }
            self.addConstraint(newConstraint)
        }
        setNeedsUpdateConstraints()
    }
}

extension UIStackView {
    func addArrangedSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}
