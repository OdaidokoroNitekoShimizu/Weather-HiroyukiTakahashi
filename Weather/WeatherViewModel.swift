//
//  WeatherViewModel.swift
//  Weather
//
//  Created by hiroyuki takahashi on R 7/11/09.
//

import Foundation
import SwiftUI
import Alamofire
import Combine

//APIからのレスポンスを保持するクラス
class WeatherViewModel: ObservableObject {

    //リクエスト用URLの共通部分とAPIキー
    let baseURL = APIProperties().baseUrl
    let apiKey = APIProperties().myAPIKey

    //レスポンスを保持する変数
    @Published var forecast:Forecast?
    @Published var location:UserLocation?

    //3日間予報リクエスト、引数はlatが緯度、lonが軽度
    func request3DaysForecast(lat:Double,lon:Double) {
        //リクエストするためのURLを作る
        let url = URL(string: baseURL + "/forecast.json")!

        //リクエストに含めるパラメータを用意
        let parameters: Parameters = [
            "key" : apiKey,//APIキー
            "q": "\(lat),\(lon)",//緯度軽度
            "days": "3",//予報を取得する日数、3日分
            "lang": "ja"//天気の概況を日本語で
            
        ]

        AF.request(url, method: .get,parameters: parameters)
            .responseDecodable(of: WeatherInfo.self){ response in

                switch response.result {
                case .success(let data):
                    //通信成功時の処理
                    self.forecast = data.forecast
                    self.location = data.location
                    print("LOCATION",data.location.name)
                case .failure(let err):
                    //通信失敗時の処理
                    print("FAILED:",err)
                }

            }

    }
}


