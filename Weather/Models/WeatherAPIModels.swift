//
//  WeatherAPIModels.swift
//  Weather
//
//  Created by hiroyuki takahashi on R 7/11/09.
//

import Foundation

//レスポンス全体の大枠
struct WeatherInfo: Codable {
    let location: UserLocation
    let forecast: Forecast

}

//ユーザーの位置とそれに関連した情報
struct UserLocation: Codable {
    let name: String
    let region: String
    let country: String
    let timezoneID: String
    let localTime: String

    //キャメルケースとスネークケースの相互変換
    enum CodingKeys: String, CodingKey {
        case name  //変換不要なものは"case プロパティ名でok"
        case region
        case country
        case timezoneID = "tz_id"
        case localTime = "localtime"
        // case Swiftで使いたい形 = "APIレスポンスの形式"
    }
}

//天気予報の情報全体
struct Forecast: Codable {
    //取得した日数分の予報
    let forecastsDay: [ForecastDay]
    enum CodingKeys: String, CodingKey {
        case forecastsDay = "forecastday"
    }
}

// 1日分の予報(1日と時間毎)
struct ForecastDay: Codable, Hashable {

    let date: String
    let day: DailyForecast
    let hour: [HourlyForecast]

    // 「2024-12-23」 → Date型に変換　→ String「2024年12月23日」の形式に変換する関数
    func toDisplayDate(_ date: String) -> String {
        let formatter = DateFormatter()  // フォーマッター生成
        formatter.dateFormat = "yyyy-MM-dd"  // 日付の形式を指定
        guard let date = formatter.date(from: date) else { return "" }  // String型を一度Date型に変換
        formatter.dateFormat = "yyyy年MM月dd日"  // 日付の形式を再度指定
        return formatter.string(from: date)  // Date型から指定した形式にしてString型に変換して返す
    }

}

struct DailyForecast: Codable, Hashable {
    let maxTemp: Double
    let minTemp: Double
    let dailyChanceOfRain: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxTemp = "maxtemp_c"
        case minTemp = "mintemp_c"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case condition

    }
}

struct HourlyForecast: Codable, Hashable {
    let time: String
    let temperature: Double
    let condition: Condition
    let chanceOfRain: Double

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temp_c"
        case condition
        case chanceOfRain = "chance_of_rain"
    }

}

struct Condition: Codable, Hashable {
    let text: String
    let icon: String
}
