//
//  UIView+Constraints.swift
//  CleanCodeDemo
//
//  Created by Hervé Bérenger on 24/06/2016.
//
//

import Foundation
import UIKit

extension UIView {

    /**
     Add constraints to center self in the superview along specified axes

     - parameter axis: Axis to center the view along in its superview

     */
    @objc(ad_centerInSuperview) public func ad_centerInSuperview() {
        ad_centerInSuperview(along: .horizontal)
        ad_centerInSuperview(along: .vertical)
    }

    @objc(ad_centerInSuperviewAlongAxis:) public func ad_centerInSuperview(along axis: UILayoutConstraintAxis) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            ad_pinTo(view: superview, attribute: .centerX, constant: 0.0)
        case .vertical:
            ad_pinTo(view: superview, attribute: .centerY, constant: 0.0)
        }
    }

    /**
     Add constraints to pin self in superview

     - parameter edges: Edges to pin the view in its superview

     - parameter insets: UIEdgeInsets to apply for each edge
     */
    @objc(ad_pinToSuperview) public func ad_pinToSuperview() {
        ad_pinToSuperview(edges: .all, insets: .zero)
    }

    @objc(ad_pinToSuperviewWithEdges:) public func ad_pinToSuperview(edges: UIRectEdge) {
        ad_pinToSuperview(edges: edges, insets: .zero)
    }

    @objc(ad_pinToSuperviewWithInsets:) public func ad_pinToSuperview(insets: UIEdgeInsets) {
        ad_pinToSuperview(edges: .all, insets: insets)
    }

    @objc(ad_pinToSuperviewWithEdges:insets:) public func ad_pinToSuperview(edges: UIRectEdge, insets: UIEdgeInsets) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            ad_pinTo(view: superview, attribute: .top, constant: insets.top)
        }
        if edges.contains(.left) {
            ad_pinTo(view: superview, attribute: .left, constant: insets.left)
        }
        if edges.contains(.bottom) {
            ad_pinTo(view: superview, attribute: .bottom, constant: -insets.bottom)
        }
        if edges.contains(.right) {
            ad_pinTo(view: superview, attribute: .right, constant: -insets.right)
        }
    }

    //MARK: - Private

    private func ad_pinTo(view: UIView, attribute: NSLayoutAttribute, constant: CGFloat) {
        view.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: .equal,
                toItem: view,
                attribute: attribute,
                multiplier: 1.0,
                constant: constant
            )
        )
    }
}
