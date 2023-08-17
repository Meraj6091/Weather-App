//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    @State  var userLocation: String = ""
    
    var body: some View {
        ZStack {
            // Background Image rendering code here
            Image("background2")
                .resizable()
                .background(.blue)
                .blur(radius: 30)
                .ignoresSafeArea()
            
            VStack {
                VStack{
                    VStack {
                        Text("\(modelData.userLocation)")
                            .font(.largeTitle)
                            .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                        
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.system(size: 100))
                            .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                            .shadow(radius: 20)
                        
                            .fontWeight(.semibold)
                        
                        HStack {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png")) //to get a imge from net getting the icon from datamodel
                            Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                                .padding()
                                .font(.title2)
                                .fontWeight(.heavy)
                            
                        }
                        
                        
                        
                        VStack(spacing: 40) {                         HStack{
                            Image(systemName: "thermometer.medium")
                                .foregroundColor(.red)
                            Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                        }
                            
                            HStack {
                                Image(systemName: "wind")
                                    .foregroundColor(.green)
                                Text("Wind Speed :\((Int)(modelData.forecast!.current.windSpeed))m/s")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                                
                                Spacer()
                                
                                Image(systemName: "safari")
                                    .foregroundColor(.blue)
                                Text("Direction :\(convertDegToCardinal(deg:modelData.forecast!.current.windDeg))")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                            }
                            
                            HStack {
                                Image(systemName: "humidity")
                                    .foregroundColor(.blue)
                                Text("Humidity :\((Int)(modelData.forecast!.current.humidity))%")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                                
                                Spacer()
                                
                                Image(systemName: "speedometer")
                                    .foregroundColor(.orange)
                                Text("Pressure :\((Int)(modelData.forecast!.current.pressure))hPg")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                            }
                            
                            HStack {
                                Image(systemName: "sunrise.fill")
                                    .foregroundColor(.yellow)
                                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunrise ?? 0))))
                                    .formatted(.dateTime.hour().minute()))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                                
                                Image(systemName: "sunset.fill")
                                    .foregroundColor(.yellow)
                                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunset ?? 0))))
                                    .formatted(.dateTime.hour().minute()))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
                
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                }
            }
            
        }
        .ignoresSafeArea(edges: [.top, .trailing, .leading])
        .preferredColorScheme(.dark)
        
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
