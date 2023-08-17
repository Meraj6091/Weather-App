//
//  NavBar.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
            Home()
                 .tabItem {
                     Image(systemName: "magnifyingglass")
                     Text("City")
                 }
             
             CurrentWeatherView()
                 .tabItem {
                     Image(systemName: "sun.max.fill")
                     Text("WeatherNow")
                 }
             
             HourlyView()
                 .tabItem{
                     Image(systemName: "clock.fill")
                     Text("HourlyView")
                 }
             ForecastView()
                 .tabItem {
                     Image(systemName: "calendar")
                     Text("ForecastView")
                 }
                 
             PollutionView()
                 .tabItem {
                     Image(systemName: "aqi.high")
                     Text("PollutionView")
                 }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

