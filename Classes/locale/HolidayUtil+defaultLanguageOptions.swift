//
//  SwiftyHolidayUtil+Locale.swift
//  HolidayLabel
//
//  Created by kazuomatz on 2019/01/24.
//  Copyright Ã‚Â© 2019 kazuomatz. All rights reserved.
//

extension SwiftyHolidayUtil {

    //This is a language-specific formatting setting with the language code as the key.
    //It is merged with the default value "commonFormatOptions", so write a different setting
    //from "commonFormatOptions".
    static internal var defaultLanguageOptions: [String: [FormatOptionKey: Any]] = [
        "ja": [
            FormatOptionKey.shortWeekPrefix: " (",
            FormatOptionKey.shortWeekSuffix: ")",
            FormatOptionKey.mediumWeekPrefix: " (",
            FormatOptionKey.mediumWeekSuffix: ")"
        ],
        "en": [
            :
        ]
    ]
}
