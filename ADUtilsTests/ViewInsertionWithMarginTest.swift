//
//  ViewInsertionWithMarginTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 21/11/16.
//
//

import Foundation

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import ADUtils
@testable import ADUtilsApp

class IntrinsicContentSizeView : UIView {

    private var contentSize: CGSize = CGSize.zero

    convenience init(contentSize: CGSize) {
        self.init()
        self.contentSize = contentSize
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

class ViewInsertionWithMargin: QuickSpec {

    override func spec() {

        describe("Pin to superview") {

            let insets = UIEdgeInsets(top: 12.0, left: 13.0, bottom: 20.0, right: 45.0)
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should pin all edges with insets") {
                subview.ad_pinToSuperview(insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithInsets"))
            }

            it("should pin top right with insets") {
                subview.ad_pinToSuperview(edges: [.top, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithInsets"))
            }

            it("should pin top left with insets") {
                subview.ad_pinToSuperview(edges: [.top, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithInsets"))
            }

            it("should pin bottom right with insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithInsets"))
            }

            it("should pin bottom left with insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithInsets"))
            }

            it("should pin all edges without insets") {
                subview.ad_pinToSuperview()
                expect(view).to(haveValidSnapshot(named: "PinAllEdgesWithoutInsets"))
            }

            it("should pin top right without insets") {
                subview.ad_pinToSuperview(edges: [.top, .right])
                expect(view).to(haveValidSnapshot(named: "PinTopRightEdgesWithoutInsets"))
            }

            it("should pin top left without insets") {
                subview.ad_pinToSuperview(edges: [.top, .left])
                expect(view).to(haveValidSnapshot(named: "PinTopLeftEdgesWithoutInsets"))
            }

            it("should pin bottom right without insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .right])
                expect(view).to(haveValidSnapshot(named: "PinBottomRightEdgesWithoutInsets"))
            }

            it("should pin bottom left without insets") {
                subview.ad_pinToSuperview(edges: [.bottom, .left])
                expect(view).to(haveValidSnapshot(named: "PinBottomLeftEdgesWithoutInsets"))
            }
        }

        describe("Center in superview") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 50, height: 50))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should center in superview") {
                subview.ad_centerInSuperview()
                expect(view).to(haveValidSnapshot(named: "CenterInSuperview"))
            }

            it("should center X in superview") {
                subview.ad_pinToSuperview(edges: [.top, .bottom])
                subview.ad_centerInSuperview(along: .horizontal)
                expect(view).to(haveValidSnapshot(named: "CenterXInSuperview"))
            }

            it("should center Y in superview") {
                subview.ad_pinToSuperview(edges: [.left, .right])
                subview.ad_centerInSuperview(along: .vertical)
                expect(view).to(haveValidSnapshot(named: "CenterYInSuperview"))
            }
        }

        describe("Constrain to size") {
            var view: UIView!
            var subview: UIView!

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = UIView()
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain to size") {
                subview.ad_constrain(to: CGSize(width: 50, height: 50))
                subview.ad_pinToSuperview(edges: [.top, .left])
                expect(view).to(haveValidSnapshot(named: "ConstrainToSize"))
            }
        }

        describe("Constrain in superview") {
            var view: UIView!
            var subview: UIView!
            let insets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 30.0, right: 40.0)

            beforeEach {
                view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
                view.backgroundColor = UIColor.white
                subview = IntrinsicContentSizeView(contentSize: CGSize(width: 300, height: 300))
                subview.backgroundColor = UIColor.red
                view.addSubview(subview)
            }

            it("should constrain in superview pin bottom left") {
                subview.ad_pinToSuperview(edges: [.bottom, .left], insets: insets)
                subview.ad_constrainInSuperview(edges: [.top, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomLeft"))
            }

            it("should constrain in superview pin bottom right") {
                subview.ad_pinToSuperview(edges: [.bottom, .right], insets: insets)
                subview.ad_constrainInSuperview(edges: [.top, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinBottomRight"))
            }

            it("should constrain in superview pin top left") {
                subview.ad_pinToSuperview(edges: [.top, .left], insets: insets)
                subview.ad_constrainInSuperview(edges: [.bottom, .right], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopLeft"))
            }

            it("should constrain in superview pin top right") {
                subview.ad_pinToSuperview(edges: [.top, .right], insets: insets)
                subview.ad_constrainInSuperview(edges: [.bottom, .left], insets: insets)
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewPinTopRight"))
            }

            it("should constrain in superview") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview()
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperview"))
            }

            it("should constrain in superview with insets") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(insets: UIEdgeInsets(value: 10.0))
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithInsets"))
            }

            it("should constrain in superview with left edge") {
                subview.ad_centerInSuperview()
                subview.ad_constrainInSuperview(edges: [.left])
                expect(view).to(haveValidSnapshot(named: "ConstrainInSuperviewWithLeftEdge"))
            }
        }
    }
}
