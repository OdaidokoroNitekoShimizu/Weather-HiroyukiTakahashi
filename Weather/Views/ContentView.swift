//
//  ContentView.swift
//  Weather
//
//  Created by hiroyuki takahashi on R 7/11/09.
//

import SwiftUI

struct ContentView: View {
    //APIへリクエストしたり、レスポンスの値を保持するオブジェクト
    @StateObject private var weathetVM = WeatherViewModel()

    // 八幡平市大更の緯度・経度
    var lat: Double = 39.91167
    var lon: Double = 141.093459
    var body: some View {

        NavigationStack{
            ScrollView{

            }
            .navigationTitle("ここに現在地を表示")//画面上部のタイトル
            .navigationBarTitleDisplayMode(.inline)//タイトルの表示方法の指定

        }
        .padding()
        //Vstackが表示されたときに実行される処理、現れる処理
        .onAppear{
            weathetVM.request3DaysForecast(lat:lat,lon:lon)
        }
    }
}

#Preview {
    ContentView()
}
