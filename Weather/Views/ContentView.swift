//
//  ContentView.swift
//  Weather
//
//  Created by hiroyuki takahashi on R 7/11/09.
//

import SwiftUI
import MapKit

struct ContentView: View {
    //APIへリクエストしたり、レスポンスの値を保持するオブジェクト
    @StateObject private var weathetVM = WeatherViewModel()
    @StateObject var locationManager = LocationManager() // 位置情報管理のオブジェクト
    // 八幡平市大更の緯度・経度
    var lat: Double = 39.91167
    var lon: Double = 141.093459
    var body: some View {
        
        NavigationStack{
            ScrollView{
                
                VStack(spacing: 20) {
                    DailyWeatherView(weatherVM: weathetVM)
                    HourlyWeatherView(weatherVM: weathetVM)
                }
                .padding()
                
            }
            //            .navigationTitle("ここに現在地を表示")//画面上部のタイトル
            .navigationTitle("現在地: \(locationManager.address)")
            .navigationBarTitleDisplayMode(.inline)//タイトルの表示方法の指定
            
        }
        .padding()
        //Vstackが表示されたときに実行される処理、現れる処理
        .onAppear{
            //            weathetVM.request3DaysForecast(lat:lat,lon:lon)
            getWeatherForecast()
        }
        // スクロールビューを下に引っ張って実行
        .refreshable {
            getWeatherForecast()
        }
    }
    
    // 現在地の天気予報取得、上から順番に処理したいのでDispatchQueue.main.async使用、先にprintが出ないように
    func getWeatherForecast() {
        DispatchQueue.main.async {
            if let location = locationManager.location {
                let latitude = location.coordinate.latitude     // 緯度
                let longitude = location.coordinate.longitude   // 軽度
                weathetVM.request3DaysForecast(lat: latitude, lon: longitude) // 天気リクエスト
                print("LAT:", latitude, "LON:", longitude)
            } else {
                print("getting weather is failed")
            }
        }
    }
}

#Preview {
    ContentView()
}
