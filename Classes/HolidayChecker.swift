//
//  HolidayChecker.swift
//
//  Created by kazuomatz on 2019/01/24.
//  Copyright Â© 2019 kazuomatz. All rights reserved.

import Foundation
public class HolidayChecker {
    internal var date: Date?
    static public func isHoliday(date: Date, regionCode: String = NSLocale.current.regionCode!) -> Bool {

        switch regionCode {

        //Japan
        case "JP":
            return HolidayChecker().checkJP(date: date)
        //US
        case "US":
            return HolidayChecker().checkUS(date: date)

        //Koria
        case "KR":
            return HolidayChecker().checkKR(date: date)

        //Vietnam
        case "VN":
            return HolidayChecker().checkVN(date: date)

            // TODOs : Impliment other country holiday check logic.
            // 1. Add HolidayChecker+XX.swift in "locale" directry.
            // 2. Impliment holiday check logic in the file.
            // 3. add case tag of region code.
            // 4. call HolidayChecker().checkXX().
            // * XX is region code.
        default:
            return false
        }
    }
}
