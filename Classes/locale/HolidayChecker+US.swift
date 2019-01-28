//
//  HolidayChecker+US.swift
//  HolidayLabel_Example
//
//  Created by KazuoMatz on 2019/01/23.
//  Copyright Â© 2019 kazuomatz All rights reserved.
//

import Foundation
extension HolidayChecker {
    internal func checkUS(date: Date) -> Bool {
        //-FIXME: This is Provisional code. only 2019 year.

        let holidays = [
            [2019, 1, 1],       //New Year's Day
            [2019, 1, 21],      //Martin Luther King, Jr. Day
            [2019, 2, 18],      //Presidents'Day
            [2019, 4, 19],      //Good Friday
            [2019, 5, 27],      //Memorial Day
            [2019, 7, 4],       //Independence Day
            [2019, 9, 2],       //Labor Day
            [2019, 10, 14],     //Columbus Day
            [2019, 11, 11],     //Veterans Day
            [2019, 11, 28],     //Thanksgiving Day
            [2019, 12, 25]      //Christmas Day
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
