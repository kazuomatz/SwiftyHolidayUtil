//
//  SwiftyHolidayUtil.swift
//  HolidayLabel
//
//  Created by kazuomatz on 2019/01/24.
//  Copyright Â© 2019 kazuomatz. All rights reserved.
//

import Foundation
import UIKit

public class SwiftyHolidayUtil {

    //Week string position
    public enum WeekPosition: String {
        case head
        case tail
    }

    //Date Fomat Style
    //DateFormatter.dateStyle
    public enum DateStyle {
        case long
        case medium
        case short
        case none
        case custom(customFormat: String)
    }

    //Date Fomat Style
    //DateFormatter.timeStyle
    public enum TimeStyle {
        case long
        case medium
        case short
        case none
        case full
        case custom(customFormat: String)
    }

    //Week Fomat Style
    public enum WeekSymbolType {
        case standalone
        case short
        case veryShort
        case shortStandalone
        case veryShortStandalone
        case custom(customFormat: String)
    }

    // key of FormatOption
    public enum FormatOptionKey: String {
        case weekPosision = "weekPosision"
        case shortWeekPrefix = "shortWeekPrefix"
        case shortWeekSuffix = "shortWeekSuffix"
        case mediumWeekPrefix = "weekPrefix"
        case mediumWeekSuffix = "weekSuffix"
        case longWeekPrefix = "longPrefix"
        case longWeekSuffix = "longSuffix"
        case weekSymbolType = "weekSymbolType"
        case sundayColor = "sundayColor"
        case saturdayColor = "saturdayColor"
        case holidayColor = "holidayColor"
        case dateStyle = "dateStyle"
        case timeStyle = "timeStyle"
    }

    //Setting common formats for each country.
    //If you want to change the format setting for each country,
    //add it to "defaultLanguageOptions" in locale/HolidayUtil+Locale.swift.
    public static let commonFormatOptions = [
        FormatOptionKey.weekPosision: WeekPosition.head,
        FormatOptionKey.shortWeekPrefix: "",
        FormatOptionKey.shortWeekSuffix: "",
        FormatOptionKey.mediumWeekPrefix: "",
        FormatOptionKey.mediumWeekSuffix: "",
        FormatOptionKey.longWeekPrefix: "",
        FormatOptionKey.longWeekSuffix: "",
        FormatOptionKey.sundayColor: UIColor.red,
        FormatOptionKey.saturdayColor: UIColor.black,
        FormatOptionKey.holidayColor: UIColor.red,
        FormatOptionKey.dateStyle: DateStyle.medium,
        FormatOptionKey.timeStyle: TimeStyle.none
        ] as [SwiftyHolidayUtil.FormatOptionKey: Any]

    // Find Week Position
    // By finding the position of EEEE from DateFormat of DateStylle.full,
    // Find the position on the day of the week from the date string.
    public static func calcWeekPostion(localeIdentifier: String) -> [FormatOptionKey: Any]? {

        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: localeIdentifier)
        dateformatter.dateStyle = .full

        // Default value by region.
        var weekRegionOption = defaultRegionOptions[
          regionCodeFromLocaleIdentifier(localeIdentifier: localeIdentifier)]
        if weekRegionOption == nil {
            weekRegionOption = [:]
        }

        // Default value by Laungage.
        var weekLanguageOption = defaultLanguageOptions[
          languageCodeFromLocaleIdentifier(localeIdentifier: localeIdentifier)]
        if weekLanguageOption == nil {
            weekLanguageOption = [:]
        }

        //Case beginning with 'EEEE'
        if dateformatter.dateFormat.hasPrefix("EEEE") {
            var components = dateformatter.dateFormat.components(separatedBy: "EEEE")
            components = components[1].components(separatedBy: " ")

            // return merged weekLanguageOption and weekRegionOption value
            return  [
                FormatOptionKey.weekPosision: WeekPosition.head,
                FormatOptionKey.shortWeekPrefix: " ",
                FormatOptionKey.shortWeekSuffix: components[0] + " ",
                FormatOptionKey.mediumWeekPrefix: " ",
                FormatOptionKey.mediumWeekSuffix: components[0] + " ",
                FormatOptionKey.longWeekPrefix: " ",
                FormatOptionKey.longWeekSuffix: components[0] + " "
                ].merging(weekRegionOption!) {(_, new) in new}.merging(weekLanguageOption!) {(_, new) in new}
        }
        //Case ending with 'EEEE'
        else if dateformatter.dateFormat.hasSuffix("EEEE") {
            let components = dateformatter.dateFormat.replacingOccurrences(of: "EEEE", with: "")
            let suffix = String(components.trimmingCharacters(in: .whitespaces).suffix(1))

            // return merged weekLanguageOption and weekRegionOption value
            return  [
                FormatOptionKey.weekPosision: WeekPosition.tail,
                FormatOptionKey.shortWeekPrefix: suffix == ", " ? ", " : " ",
                FormatOptionKey.shortWeekSuffix: " ",
                FormatOptionKey.mediumWeekPrefix: suffix == ", " ? ", " : " "
              ].merging(weekRegionOption!) {( _, new) in new}.merging(weekLanguageOption!) {(_, new) in new}
        } else {
            return nil
        }
    }

    // Find language code from localeIdentifier.
    public static func languageCodeFromLocaleIdentifier(localeIdentifier: String) -> String {
        let array = localeIdentifier.split(separator: "_")
        var lang = ""
        if array.count == 1 || array.count == 2 {
            lang = String(array[0])
        } else if array.count > 2 {
            lang = array[0...(array.count - 2)].joined(separator: "_")
        } else {
            lang = "en"
        }
        return lang
    }

    // Find region code from localeIdentifier.
    public static func regionCodeFromLocaleIdentifier(localeIdentifier: String) -> String {
        let array = localeIdentifier.split(separator: "_")
        return array.count > 1 ? String(array[array.count - 1]) : "US"
    }
}
