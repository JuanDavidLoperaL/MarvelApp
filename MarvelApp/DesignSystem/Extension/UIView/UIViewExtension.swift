//
//  UIViewExtension.swift
//  DesignSystem
//
//  Created by Juan David Lopera Lopez on 24/01/22.
//

import Foundation
import UIKit

public extension UIView {
    func apply(background: DSBackgroundColor) {
        self.backgroundColor = background.getColor()
    }
}
