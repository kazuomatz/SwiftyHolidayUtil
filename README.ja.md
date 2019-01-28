# SwiftyHolidayUtil

[![Version](https://img.shields.io/cocoapods/v/SwiftyHolidayUtil.svg?style=flat)](https://cocoapods.org/pods/SwiftyHolidayUtil)
[![License](https://img.shields.io/cocoapods/l/SwiftyHolidayUtil.svg?style=flat)](https://cocoapods.org/pods/SwiftyHolidayUtil)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyHolidayUtil.svg?style=flat)](https://cocoapods.org/pods/SwiftyHolidayUtil)

## 概要

SwiftyHolidayUtilは、土曜日・日曜日・祝日をハイライトするライブラリーです。

<img src="https://user-images.githubusercontent.com/2704723/51838188-f1a12c80-2348-11e9-8b22-45de8cac84e0.png" width="50%"/>


## サンプルプログラム

サンプルプロジェクトを実行するには、Exampleディレクトリーで `pod install`を実行します。

## 要件

- Swit 4.2

## インストール方法

[CocoaPods](https://cocoapods.org)で使用する場合は、.PodFileに以下を記述します。
```ruby
pod 'SwiftyHolidayUtil'
```
## 使用方法

UILabelのExtensionで実装しているため、簡単に使用することができます。

```swift
import SwiftyHolidayUtil

let label:UILabel = UILabel()
label.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
label.date = Date()
```
もし、iPhoneの使用言語が英語で地域がアメリカで設定されている場合（en_US)、以下のように表示されます。

<img width="180" alt="2019-01-28 22 36 13" src="https://user-images.githubusercontent.com/2704723/51839714-5c546700-234d-11e9-8e6d-8fd1dba0561a.png"/>

### DateStyleの設定

日付のスタイル（SwiftyHolidayUtil.dateStyle）を指定できます。

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

### Localeの設定

ロケールの設定が可能です。書式は言語コードに、祝日の判定と、土・日・祝日の色の表示は、地域コード（Regionコード)によって決定されます。

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
| .shortWeekPrefix | String : dateStyle: .long の場合の接頭辞を指定します。 |
| .shortWeekSuffix | String :  dateStyle: .long の場合の接尾辞を指定します。|
| .mediumWeekPrefix | String : dateStyle: .medium の場合の接頭辞を指定します。 |
| .mediumWeekSuffix | String : dateStyle: .medium の場合の接尾辞を指定します。 |
| .longWeekPrefix | String : dateStyle: .long の場合の接頭辞を指定します。|
| .longWeekSuffix | String : dateStyle: .long の場合の接尾辞を指定します。 |
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


## 表示色について

日本は土曜日は青、日曜・祝日は赤が慣例だけど、他の国は千差万別だとお思います。
リージョン毎で設定できるように作ってあるので、以下のような組み合わせで初期値として実装が可能です。
プルリクください。

- HolidayUtil+defaulRegionOptions.swift

```swift
"JP": [
            FormatOptionKey.saturdayColor: UIColor.blue,
            FormatOptionKey.sundayColor: UIColor.red,
            FormatOptionKey.holidayColor: UIColor.red
        ]
```

## 祝日の判定ロジック

現在は日本の判定ロジック([fumiyasac](https://github.com/fumiyasac)さんの[fumiyasac/handMadeCalendarOfSwift
](https://github.com/fumiyasac/handMadeCalendarOfSwift))のみを実装しています。

USと韓国とベトナムの暫定コードを実装していますが、このコードは2019年しか正しく動作しません。
各国の祝日判定のロジックがあれば実装してもらえたらと思います。

## Author

kazuomatz, getlasterror@gmail.com

## License

SwiftyHolidayUtil is available under the MIT license. See the LICENSE file for more info.
