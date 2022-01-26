//
//  DSBackgroundColor.swift
//  DesignSystem
//
//  Created by Juan David Lopera Lopez on 24/01/22.
//

import UIKit

public enum DSBackgroundColor {
    case mainScreen
    case clear
    
    func getColor() -> UIColor {
        switch self {
        case .clear:
            return .clear
        case .mainScreen:
            let mainBackgroundColorName: String = "MainBackground"
            return UIColor(named: mainBackgroundColorName, in: bundle, compatibleWith: nil) ?? UIColor.white
        }
    }
}

