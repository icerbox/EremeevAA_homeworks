//
//  Constants.swift
//  Lesson14
//
//  Created by Андрей Антонен on 12.12.2021.
//

import UIKit

enum Constants {
    enum Colors {
        static var greenPrimary: UIColor? {
            UIColor(named: "GreenPrimary")
        }
        static var greenSecondary: UIColor? {
            UIColor(named: "GreenSecondary")
        }
    }
    enum Fonts {
        static var systemHeading: UIFont {
            UIFont.systemFont(ofSize: 30, weight: .semibold)
        }
        static var systemText: UIFont {
            UIFont.systemFont(ofSize: 16)
        }
    }
    enum Image {
        static let house = UIImage(systemName: "house")
        static let lasso = UIImage(systemName: "lasso")
        static let pencil = UIImage(systemName: "pencil")
    }
}
