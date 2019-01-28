//
//  SwiftyHolidayUtil+Locale.swift
//  HolidayLabel
//
//  Created by kazuomatz on 2019/01/24.
//  Copyright Â© 2019 kazuomatz. All rights reserved.
//

extension SwiftyHolidayUtil {

    //This is a region-specific formatting setting with the region code as the key.
    //It is merged with the default value "commonFormatOptions", so write a different setting
    //from "commonFormatOptions".
    static internal let defaultRegionOptions: [String: [FormatOptionKey: Any]] = [
        "JP": [
            FormatOptionKey.saturdayColor: UIColor.blue,
            FormatOptionKey.sundayColor: UIColor.red,
            FormatOptionKey.holidayColor: UIColor.red
        ]
    ]

}
