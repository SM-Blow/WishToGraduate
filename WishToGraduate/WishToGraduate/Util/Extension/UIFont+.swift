//
//  UIFont+.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/05.
//

import UIKit

extension UIFont {
    
    public static func fontGuide(_ fontLevel: FontLevel) -> UIFont {
        return UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
    }
}
