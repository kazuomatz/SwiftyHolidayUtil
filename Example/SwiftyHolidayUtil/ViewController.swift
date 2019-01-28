//
//  ViewController.swift
//  SwiftyHolidayUtil
//
//  Created by kazuomatz on 01/25/2019.
//  Copyright (c) 2019 kazuomatz. All rights reserved.
//

import UIKit
import SwiftyHolidayUtil

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!

    var date: Date = Date()
    var dayCount: Int = 0
    var calendar = NSCalendar(identifier: .gregorian)!
    var selectedIndex = 0
    var selectedDateType = "short"
    var availableLocaleIdentifiers: [String] = Locale.availableIdentifiers.sorted()
    var availableHolidayChecker = ["Current Locale", "ja_JP", "en_US", "ko_KR", "vi_VN"]
    var dateType = ["short", "medium", "long"]

    @IBOutlet weak var  changeButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem?

    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.availableLocaleIdentifiers = self.availableHolidayChecker + self.availableLocaleIdentifiers
        var dateComponent = calendar.components([.year, .month, .day, .hour, .minute, .second], from: date)

        dateComponent.day = 1
        dateComponent.hour = 0
        dateComponent.minute = 0
        dateComponent.second = 0

        self.date = calendar.date(from: dateComponent)!

        dateComponent.year = dateComponent.year! + 1
        dateComponent.day = 0
        let dateEndOfMonth = calendar.date(from: dateComponent)!
        dayCount = calendar.component(.year, from: dateEndOfMonth)

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.isHidden = true

        self.changeButton.title = "Change"
        self.changeButton.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITalbeView datasource / delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        let newDate = calendar.date(
            byAdding: .day, value: indexPath.row,
            to: calendar.startOfDay(for: self.date)) ?? Date()
        
        cell.textLabel!.locale = Locale(identifier: "ja_JP")
        cell.textLabel!.dateStyle = .medium
        cell.textLabel!.holidayFormatOptions = [
            .holidayColor: "#077705",
            .mediumWeekPrefix: "【",
            .mediumWeekSuffix: "】",
            .weekPosision: SwiftyHolidayUtil.WeekPosition.head
        ]
        cell.textLabel!.date = newDate
        /*
        
        if self.selectedIndex > 0 {
            cell.textLabel!.locale = Locale(identifier: self.availableLocaleIdentifiers[self.selectedIndex])
        } else {
            cell.textLabel!.locale = nil
        }
        switch self.selectedDateType {
        case "short":
            cell.textLabel!.dateStyle = .short
        case "long":
            cell.textLabel!.dateStyle = .long
        default:
            cell.textLabel!.dateStyle = .medium
        }
        cell.textLabel!.date = newDate*/
        return cell
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    // MARK: - UIPickerView datasource / delegate
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dateType.count
        } else {
            return availableLocaleIdentifiers.count
        }
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 0 {
            return dateType[row]
        } else {
            return availableLocaleIdentifiers[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        if  component == 0 {
            self.selectedDateType = dateType[row]
        } else {
            self.selectedIndex = row
        }
    }

    // Tape Change Button
    @IBAction func onLocaleChange() {
        if changeButton.title == "Change" {
            changeButton.title = "Done"
            self.pickerView.isHidden = false
        } else {
            changeButton.title = "Change"
            self.pickerView.isHidden = true
            self.tableView.reloadData()
        }
    }
}
