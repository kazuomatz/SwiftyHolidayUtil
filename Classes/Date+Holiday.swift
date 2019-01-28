//
//  SwiftyHolidayUtil+Date.swift
//  CalculateCalendarLogic
//
//  Created by kazuomatz on 2019/01/27.
//

import Foundation

// MARK: - Date Extention
public extension Date {
    public static func getLocalIdetifier() -> String {
      return "\(String(describing: Locale.preferredLanguages.first!))_\(String(describing: Locale.current.regionCode!))"
    }

    public func attributeStringWithWeek(
        localeIdentifier: String? = Date.getLocalIdetifier(),
        formatOption: [SwiftyHolidayUtil.FormatOptionKey: Any]? = nil) -> NSAttributedString {

        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier ?? Date.getLocalIdetifier())

        let localeIdentifier = dateFormatter.locale.identifier

        let lang = SwiftyHolidayUtil.languageCodeFromLocaleIdentifier(localeIdentifier: localeIdentifier)
        let regionCode = SwiftyHolidayUtil.regionCodeFromLocaleIdentifier(localeIdentifier: localeIdentifier)

        // Get FormatOption with lang
        var option = SwiftyHolidayUtil.defaultLanguageOptions[lang]
        if option == nil {
            option = SwiftyHolidayUtil.defaultLanguageOptions["en"]
        }

        // Merge Lang Format Option
        let week = SwiftyHolidayUtil.calcWeekPostion(localeIdentifier: localeIdentifier)
        if week != nil {
            option = week?.merging(option!) {(new, _) in new}
        }

        // Merge Common Format Options
        option = SwiftyHolidayUtil.commonFormatOptions.merging(option!) {(_, new) in new}

        // Merge Parameter Format Options
        if formatOption != nil {
            option = option?.merging(formatOption!) {(_, new) in new}
        }

        // Holiday Format
        switch option?[SwiftyHolidayUtil.FormatOptionKey.dateStyle] as? SwiftyHolidayUtil.DateStyle {
        case .long?:
            dateFormatter.dateStyle = .long
        case .short?:
            dateFormatter.dateStyle = .short
        case .medium?:
            dateFormatter.dateStyle = .medium
        case .custom(let customFormat)?:
            dateFormatter.dateFormat = customFormat
        default:
            dateFormatter.dateStyle = .long
        }

        //dateFormatter.timeStyle = .none
        let text: NSMutableAttributedString = NSMutableAttributedString()
        let cal: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!

        let comp: NSDateComponents = cal.components(
            [.year, .month, .day, .weekday, .hour, .minute],
            from: self
            ) as NSDateComponents
        let weekDay: Int = comp.weekday

        //Sunday
        let isSunday: Bool = (weekDay == 1)

        //Saturday
        let isSaturday: Bool = (weekDay == 7)

        //National Holiday
        var isHoliday: Bool = false

        if HolidayChecker.isHoliday(date: self, regionCode: regionCode) {
            isHoliday = true
        }

        // Format Week String
        var weekStr = ""
        var weekPrefixKey: SwiftyHolidayUtil.FormatOptionKey = .mediumWeekPrefix
        var weekSuffixKey: SwiftyHolidayUtil.FormatOptionKey = .mediumWeekSuffix
        if option?[SwiftyHolidayUtil.FormatOptionKey.weekSymbolType] == nil {
            switch option?[SwiftyHolidayUtil.FormatOptionKey.dateStyle] as? SwiftyHolidayUtil.DateStyle {
            case .short?:
                weekStr = dateFormatter.veryShortWeekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekSuffix
            case .long?:
                weekStr = dateFormatter.weekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.longWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.longWeekSuffix
            case .medium?:
                weekStr = dateFormatter.shortWeekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.mediumWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.mediumWeekSuffix
            case .custom(let customFormat)?:
                var format: String = customFormat
                format = format.replacingOccurrences(of: "E", with: "")
                weekStr = ""
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekSuffix
                option?[weekPrefixKey] = ""
                option?[weekSuffixKey] = ""
                dateFormatter.dateFormat = format
            default: break
            }
        } else {
            switch option?[SwiftyHolidayUtil.FormatOptionKey.weekSymbolType] as? SwiftyHolidayUtil.WeekSymbolType {
            case .short?:
                weekStr = dateFormatter.shortWeekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekSuffix
            case .shortStandalone?:
                weekStr = dateFormatter.shortStandaloneWeekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekSuffix
            case .standalone?:
                weekStr = dateFormatter.weekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.mediumWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.mediumWeekSuffix
            case .veryShort?:
                weekStr = dateFormatter.veryShortWeekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekSuffix
            case .veryShortStandalone?:
                weekStr = dateFormatter.veryShortStandaloneWeekdaySymbols[weekDay-1]
                weekPrefixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekPrefix
                weekSuffixKey = SwiftyHolidayUtil.FormatOptionKey.shortWeekSuffix
            case .custom(let customFormat)?:
                let weekformat = DateFormatter()
                dateFormatter.dateFormat = dateFormatter.dateFormat.replacingOccurrences(of: "E", with: "")
                weekformat.locale = Locale(identifier: localeIdentifier)
                weekformat.dateFormat = customFormat
                weekStr = weekformat.string(from: self)
            case .none: break
            }

        }

        //Week Color Settig
        var weeekColor: UIColor = .black
        if isHoliday {
            weeekColor = UIColor.parseColor(
              color: option?[SwiftyHolidayUtil.FormatOptionKey.holidayColor] ?? "#000000"
            )
        } else if isSaturday {
            weeekColor = UIColor.parseColor(
              color: option?[SwiftyHolidayUtil.FormatOptionKey.saturdayColor] ?? "#000000"
            )
        } else if isSunday {
            weeekColor = UIColor.parseColor(
              color: option?[SwiftyHolidayUtil.FormatOptionKey.sundayColor] ?? "#000000"
            )
        }

        // Week String (Head)
        if option?[SwiftyHolidayUtil.FormatOptionKey.weekPosision] as? SwiftyHolidayUtil.WeekPosition == .head {
            text.append(NSAttributedString(string: option?[weekPrefixKey] as? String ?? ""))
            text.append (
                NSAttributedString(string: weekStr, attributes: [NSAttributedString.Key.foregroundColor: weeekColor])
            )
            text.append(NSAttributedString(string: option?[weekSuffixKey] as? String ?? ""))
        }

        // Date Format
        text.append (
            NSAttributedString(string: dateFormatter.string(from: self))
        )

        // Week String (Tail)
        if option?[SwiftyHolidayUtil.FormatOptionKey.weekPosision] as? SwiftyHolidayUtil.WeekPosition == .tail {
            var prefix = option?[weekPrefixKey] as? String
            if prefix?.count == 0 {
                prefix = prefix!  + " "
            }
            text.append(NSAttributedString(string: prefix!))
            text.append (
                NSAttributedString(string: weekStr, attributes: [.foregroundColor: weeekColor])
            )
            text.append(NSAttributedString(string: option?[weekSuffixKey] as! String))
        }

        // Time Format
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        var formatTime = true
        switch option?[SwiftyHolidayUtil.FormatOptionKey.timeStyle] as? SwiftyHolidayUtil.TimeStyle {
        case .none:
            dateFormatter.timeStyle = .none
            formatTime = false
        case .long?:
            dateFormatter.timeStyle = .long
        case .short?:
            dateFormatter.timeStyle = .short
        case .medium?:
            dateFormatter.timeStyle = .medium
        case .full?:
            dateFormatter.timeStyle = .full
        case .custom(let customFormat)?:
            dateFormatter.dateFormat = customFormat
        case .some(.none):
            dateFormatter.timeStyle = .none
        }
        if formatTime {
            text.append (
                NSAttributedString(string: " ")
            )
            text.append (NSAttributedString(string: dateFormatter.string(from: self)))
        }
        return text
    }
}
