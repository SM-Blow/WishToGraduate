//
//  FontLevel.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/05.
//

import Foundation

public enum FontLevel {
    case title          // 15pt / medium
    case title_bold     // 15pt / bold
    case placeholder    // 14pt / regular
    case h1             // 18pt / bold
    case h2             // 12pt / medium
    case h2_bold        // 12pt / bold
    case h3             // 13pt / medium
    case h4             // 10pt / bold
    case m1             // 13pt / bold
    case bt1            // 10pt / bold
    case link1          // 11pt / medium
    case date1          // 10pt / medium
}

extension FontLevel {
    
    public var fontWeight: String {
        switch self {
        case .title:
            return NotoSansKRType.medium.rawValue
        case .title_bold:
            return NotoSansKRType.bold.rawValue
        case .placeholder:
            return NotoSansKRType.regular.rawValue
        case .h1:
            return NotoSansKRType.bold.rawValue
        case .h2:
            return NotoSansKRType.medium.rawValue
        case .h2_bold:
            return NotoSansKRType.bold.rawValue
        case .h3:
            return NotoSansKRType.medium.rawValue
        case .h4:
            return NotoSansKRType.bold.rawValue
        case .m1:
            return NotoSansKRType.bold.rawValue
        case .bt1:
            return NotoSansKRType.bold.rawValue
        case .link1:
            return NotoSansKRType.medium.rawValue
        case .date1:
            return NotoSansKRType.medium.rawValue
            
        }
    }
    
    public var fontSize: CGFloat {
        switch self {
        case .title:
            return 15
        case .title_bold:
            return 15
        case .placeholder:
            return 14
        case .h1:
            return 18
        case .h2:
            return 12
        case .h2_bold:
            return 12
        case .h3:
            return 13
        case .h4:
            return 10
        case .m1:
            return 13
        case .bt1:
            return 10
        case .link1:
            return 11
        case .date1:
            return 10
        }
    }
}


