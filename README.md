# SwiftyHolidayUtil

[![CI Status](https://img.shields.io/travis/kazuomatz/SwiftyHolidayUtil.svg?style=flat)](https://travis-ci.org/kazuomatz/SwiftyHolidayUtil)
[![Version](https://img.shields.io/cocoapods/v/SwiftyHolidayUtil.svg?style=flat)](https://cocoapods.org/pods/SwiftyHolidayUtil)
[![License](https://img.shields.io/cocoapods/l/SwiftyHolidayUtil.svg?style=flat)](https://cocoapods.org/pods/SwiftyHolidayUtil)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyHolidayUtil.svg?style=flat)](https://cocoapods.org/pods/SwiftyHolidayUtil)

## About

SwiftyHolidayUtil is a library for highlighting holidays.

<img src="https://user-images.githubusercontent.com/2704723/51838188-f1a12c80-2348-11e9-8b22-45de8cac84e0.png" width="50%"/>


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- Swit 4.2

## Installation

SwiftyHolidayUtil is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyHolidayUtil'
```

## Usage

It is very simple. When using as UILabel Extension, write as follows.

```swift
import SwiftyHolidayUtil

let label:UILabel = UILabel()
label.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
label.date = Date()
```

If the locale of your device is "en_US", it is displayed as follows.

<img width="180" alt="2019-01-28 22 36 13" src="https://user-images.githubusercontent.com/2704723/51839714-5c546700-234d-11e9-8e6d-8fd1dba0561a.png"/>

### DateStyle

SwiftyHolidayUtil.dateStyle

| dateStyle |
|----|
| .short |
| .medium (default) |
| .long |
| .custom(customFormat:String) |


```swift
label.dateStyle = .short
label.date = Date()
```

<img width="180" alt="2019-01-28 22 44 20" src="https://user-images.githubusercontent.com/2704723/51840058-5c089b80-234e-11e9-96fd-e9d4e149a852.png">

```swift
label.dateStyle = .long
label.date = Date()
```
<img width="261" alt="2019-01-28 22 46 00" src="https://user-images.githubusercontent.com/2704723/51840102-8195a500-234e-11e9-9f8d-28c076809353.png">

### Locale

```swift
label.locale = Locale(identifier: "ja_JP")
label.dateStyle = .long
label.date = Date()
```
<img width="219" alt="2019-01-28 22 49 47" src="https://user-images.githubusercontent.com/2704723/51840340-2617e700-234f-11e9-824a-540ae6168320.png">

```swift
label.locale = Locale(identifier: "ja_JP")
label.dateStyle = .mediunm
label.date = Date()
```
<img width="172" alt="2019-01-28 22 50 36" src="https://user-images.githubusercontent.com/2704723/51840347-29ab6e00-234f-11e9-8b45-da53520ded38.png">

### Options

SwiftyHolidayUtil.holidayFormatOptions

| FormatOptionKey | value |
|----|----|
| .holidayColor |  UIColor or HexString (ex. "#FF0000") |
| .saturdayColor | UIColor or HexString |
| .sundayColor | UIColor or HexString |
| .weekSymbolType | WeekSymbolType.standalone / .short / .veryshort |
| .weekPosision | WeekPosition.head / .tail |
| .shortWeekPrefix | String : Prefix of week string at long date style |
| .shortWeekSuffix | String : Suffix of week String at short date style|
| .mediumWeekPrefix | String : Prefix of week String at medium date syle |
| .mediumWeekSuffix | String : Suffix of week String at short date Style |
| .longWeekPrefix | String : Prefix of week String at long date Style |
| .longWeekSuffix | String : Suffix of week String at long date Style |
| .timeStyle | TimeStyle.long / .medium / .short / .none(default) / .full / .custom(customFormat: String)|

```swift
label.locale = Locale(identifier: "ja_JP")
label.dateStyle = .mediunm
label.holidayFormatOptions = [
            .holidayColor: "#077705",
            .mediumWeekPrefix: "【",
            .mediumWeekSuffix: "】",
            .weekPosision: SwiftyHolidayUtil.WeekPosition.head
        ]
label.date = Date()
```
<img width="204" alt="2019-01-28 23 41 09" src="https://user-images.githubusercontent.com/2704723/51843516-89f1de00-2356-11e9-8547-46e15ce9223c.png">


## Author

kazuomatz, getlasterror@gmail.com

## License

SwiftyHolidayUtil is available under the MIT license. See the LICENSE file for more info.
