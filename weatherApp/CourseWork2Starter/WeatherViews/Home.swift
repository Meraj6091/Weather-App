//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 10/03/2023.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .background(.blue)
                .blur(radius: 30)
                .ignoresSafeArea()
            
            
            VStack (spacing: 20) {
                
                VStack {
                    Text(userLocation)
                    //                    .font(.largeTitle)
                        .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                        .fontWeight(.heavy)
                    
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                        .formatted(.dateTime.year().hour().month().day()))
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    .padding()
                    .font(.title)
                }
                
                Spacer()
                
                Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                    .font(.title2)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity : \(modelData.forecast!.current.humidity)")
                    .font(.title2)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure: \((Int)(modelData.forecast!.current.pressure))hPa")
                    .font(.title2)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    .shadow(color: .black, radius: 0.5)
                
                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"))
                    Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue)")
                        .padding()
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                }
                
                Spacer()
                
                Button {
                    self.isSearchOpen.toggle()
                } label: {
                    Text("Change Location")
                        .bold()
                        .font(.system(size: 30))
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .sheet(isPresented: $isSearchOpen) {
                    SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                }
                
                Spacer()
                
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                }
                
            }
        }
        .preferredColorScheme(.dark)
    }
    
}
