//
//  HolidayChecker+KR.swift
//  HolidayLabel
//
//  Created by KazuoMatz on 2019/01/23.
//  Copyright Â© 2019 kazuomatz All rights reserved.
//

import Foundation
extension HolidayChecker {
    internal func checkKR(date: Date) -> Bool {

        // FIXME This is Provisional code. only 2019 year.

        let holidays = [
            [2019, 1, 1],
            [2019, 2, 4],
            [2019, 2, 5],
            [2019, 2, 6],
            [2019, 3, 1],
            [2019, 5, 5],
            [2019, 5, 6],
            [2019, 5, 12],
            [2019, 6, 6],
            [2019, 8, 15],
            [2019, 9, 12],
            [2019, 9, 13],
            [2019, 9, 14],
            [2019, 10, 3],
            [2019, 10, 9],
            [2019, 12, 25]
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
