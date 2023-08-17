//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var modelData: ModelData
    @State  var userLocation: String = ""
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .background(.blue)
                .blur(radius: 30)
                .ignoresSafeArea()
            
            VStack {
                                
                Label {
                    Text("\(modelData.userLocation)")
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "mappin")
                        .foregroundColor(.red)
                }
                .padding()
                .font(.title)
                .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                .multilineTextAlignment(.center)
                
                
                Text("\((Int)(modelData.forecast!.current.temp))ºC")
                    .font(.system(size: 90))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"))
                    //to get a imge from net getting the icon from datamodel
                    Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                        .padding()
                        .font(.title2)
                        .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                }
                
                
                
                Text("Air Quality Data")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                
                HStack {
                    VStack {
                        Image("so2").cornerRadius(10)
                        Text("\(String(format: "%.2f" , modelData.airPollution?.list[0].components.so2 ?? 0))")
                            .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    }
                    
                    VStack {
                        Image("no").cornerRadius(10)
                        Text("\(String(format: "%.2f" , modelData.airPollution?.list[0].components.no ?? 0))")
                            .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    }
                    
                    VStack {
                        Image("voc").cornerRadius(10)
                        Text("\(String(format: "%.2f" , modelData.airPollution?.list[0].components.nh3 ?? 0))")
                            .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    }
                    
                    VStack {
                        Image("pm").cornerRadius(10)
                        Text("\(String(format: "%.2f" , modelData.airPollution?.list[0].components.pm10 ?? 0))")
                            .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    }
                }
            }
            .onAppear{
                Task.init {
                    
                    try await self.modelData.loadAirPollutionData()
                }
            }
            .preferredColorScheme(.dark)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}
