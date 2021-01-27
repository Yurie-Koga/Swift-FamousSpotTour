//
//  PaddingLabel.swift
//
//
//  Created by Uji Saori on 2021-01-22.
//

// Usage
//let lbl = PaddingLabel(top: 5, bottom: 5, left: 10, right: 10)
//lbl.translatesAutoresizingMaskIntoConstraints = false
//lbl.text = String(describing: tagName)
//lbl.layer.borderWidth = 2.0
//lbl.layer.cornerRadius = 3


import Foundation
import UIKit

class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    required init(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
