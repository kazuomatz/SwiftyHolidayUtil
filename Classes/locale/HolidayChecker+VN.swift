//
//  HolidayChecker+US.swift
//  HolidayLabel
//
//  Created by KazuoMatz on 2019/01/23.
//  Copyright Â© 2019 kazuomatz All rights reserved.
//

import Foundation
extension HolidayChecker {
    internal func checkVN(date: Date) -> Bool {

        //- FIXME: This is Provisional code. only 2019 year.

        let holidays = [
            [2019, 1, 1],     //International New Year's Day
            [2019, 2, 4],     //Vietnamese New Year's Eve
            [2019, 2, 5],     //Vietnamese New Year
            [2019, 2, 6],     //Tet holiday
            [2019, 2, 7],     //Tet holiday
            [2019, 2, 8],     //Tet holiday
            [2019, 4, 14],    //Hung Kings Festival
            [2019, 4, 15],    //Hung Kings Festival holiday
            [2019, 4, 30],    //Liberation Day/Reunification Day
            [2019, 5, 1],     //International Labor Day
            [2019, 9, 2]     //Independence Day
        ]

        let cal: NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let dateComponent: NSDateComponents = cal.components(
            [.year, .month, .day],
            from: date
            ) as NSDateComponents

        let year = dateComponent.year
        let month = dateComponent.month
        let day = dateComponent.day

        for holiday in holidays {
            if holiday[0] == year && holiday[1] == month && holiday[2] == day {
                return true
            }
        }
        return false
    }

}
