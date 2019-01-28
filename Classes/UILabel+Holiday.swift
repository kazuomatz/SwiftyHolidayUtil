//
//  UILabel+Holiday.swift

//  Created by Kazuomatz on 2019/01/23.

import Foundation
import UIKit

// MARK: - UIColor Extention
public extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        var hexString = hex
        if hexString.hasPrefix("#") {
            hexString = String(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...])
        }
        let value = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let red = CGFloat(Int(value[0] + value[1], radix: 16) ?? 0) / 255.0
        let green = CGFloat(Int(value[2] + value[3], radix: 16) ?? 0) / 255.0
        let blue = CGFloat(Int(value[4] + value[5], radix: 16) ?? 0) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: min(max(alpha, 0), 1))
    }

    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }

    internal static func parseColor(color: Any) -> UIColor {
        if color is UIColor {
            return color as! UIColor
        } else if color is String {
            return UIColor(hex: color as! String)
        } else {
            return .black
        }
    }
}

private var associatedObjectsKey1: UInt8 = 0
private var associatedObjectsKey2: UInt8 = 0
private var associatedObjectsKey3: UInt8 = 0
private var associatedObjectsKey4: UInt8 = 0

// MARK: - UILabel Extention
public extension UILabel {

    // date Stored property
    var date: Date {
        get {
            return (objc_getAssociatedObject(self, &associatedObjectsKey1) ?? 0) as! Date
        }
        set(date) {
            objc_setAssociatedObject(self, &associatedObjectsKey1, date, .OBJC_ASSOCIATION_RETAIN)
            self.attributedText = date.attributeStringWithWeek(
              localeIdentifier: self.locale?.identifier, formatOption: self.holidayFormatOptions)
        }
    }

    // locale Stored property
    var locale: Locale? {
        get {
            return (objc_getAssociatedObject(self, &associatedObjectsKey2) ?? 0) as? Locale
        }
        set(locale) {
            objc_setAssociatedObject(self, &associatedObjectsKey2, locale, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    // dateStyle Stored property
    var dateStyle: SwiftyHolidayUtil.DateStyle? {
        get {
            return (objc_getAssociatedObject(self, &associatedObjectsKey3) ?? 0) as? SwiftyHolidayUtil.DateStyle
        }
        set(dateStyle) {
            if self.holidayFormatOptions == nil {
                self.holidayFormatOptions = [:]
            }
            self.holidayFormatOptions = self.holidayFormatOptions?.merging(
            [SwiftyHolidayUtil.FormatOptionKey.dateStyle: dateStyle!]) {(_, new) in new}
            objc_setAssociatedObject(self, &associatedObjectsKey3, dateStyle, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    // holidayFormatOptions Stored property
    var holidayFormatOptions: [SwiftyHolidayUtil.FormatOptionKey: Any]? {
        get {
            return (
              objc_getAssociatedObject(
                self, &associatedObjectsKey4) ?? 0) as? [SwiftyHolidayUtil.FormatOptionKey: Any]
        }
        set(option) {
            objc_setAssociatedObject(self, &associatedObjectsKey4, option, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
