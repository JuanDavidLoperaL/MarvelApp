//
//  LabelStyle.swift
//  DesignSystem
//
//  Created by Juan David Lopera Lopez on 24/01/22.
//

import UIKit

public enum LabelStyle {
    struct Configuration {
        var font: UIFont
        var textColor: DSTextColor
        var align: NSTextAlignment
    }

    case h1Medium(align: NSTextAlignment, color: DSTextColor = .black)
    case h2Regular(align: NSTextAlignment, color: DSTextColor = .black)
    
    func getConfiguration() -> Configuration {
        switch self {
        case let .h1Medium(align, color):
            let font: UIFont = UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.medium)
            let configuration: Configuration = Configuration(font: font,
                                                             textColor: color,
                                                             align: align)
            return configuration
        case let .h2Regular(align, color):
            let font: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
            let configuration: Configuration = Configuration(font: font,
                                                             textColor: color,
                                                             align: align)
            return configuration
        }
    }
}

