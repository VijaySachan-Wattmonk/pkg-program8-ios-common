//
//  EUIStackView.swift
//  pkg-program8-ios-common
//
//  Created by Vijay Sachan on 5/27/25.
//
import UIKit
extension UIStackView {
    
    public func fw_removeAllArrangedSubviews() {
        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
