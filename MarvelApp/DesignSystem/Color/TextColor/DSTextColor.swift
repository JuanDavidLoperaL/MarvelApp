//
//  DSTextColor.swift
//  DesignSystem
//
//  Created by Juan David Lopera Lopez on 24/01/22.
//

import Foundation
import UIKit

public enum DSTextColor {
    case black
    case body
    
    func getColor() -> UIColor {
        switch self {
        case .black:
            let blackColorName: String = "Black"
            return UIColor(named: blackColorName, in: bundle, compatibleWith: nil) ?? UIColor.black
        case .body:
            let bodyTextColorName: String = "BodyText"
            return UIColor(named: bodyTextColorName, in: bundle, compatibleWith: nil) ?? UIColor.black
        }
    }
}

