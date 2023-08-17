//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
   
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png"))
            Spacer()
            VStack {
                Text("\(day.weather[0].weatherDescription.rawValue)")
                HStack {
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt ))))
                        .formatted(.dateTime.weekday()))
                    
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt ))))
                        .formatted(.dateTime.day()))
                }
            }
            Spacer()
            Text("\((Int)(day.temp.min))ºC")
            Text("/ \((Int)(day.temp.max))ºC")
        }

    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
