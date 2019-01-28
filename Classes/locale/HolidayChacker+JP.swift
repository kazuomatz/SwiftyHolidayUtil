//
//  HolidayChacker+JA.swift
//  HolidayLabel: HolidayChacker(JA:Japan)
//
//  Created by KazuoMatz on 2019/01/23.
//  Copyright © 2019 kazuomatz All rights reserved.
//

import CalculateCalendarLogic
extension HolidayChecker {
    internal func checkJP(date: Date) -> Bool {
        let cal:NSCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let dateComponent: NSDateComponents = cal.components(
            [.year,.month,.day],
            from: date
            ) as NSDateComponents

        // Hodliday check logic of japan is
        // CalculateCalendarLogic : fumiyasac/handMadeCalendarAdvance
        // https://github.com/fumiyasac/handMadeCalendarAdvance
        return CalculateCalendarLogic().judgeJapaneseHoliday(
            year: dateComponent.year,
            month: dateComponent.month,
            day: dateComponent.day)
    }
}

