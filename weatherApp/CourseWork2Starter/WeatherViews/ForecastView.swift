//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        
        ZStack {
            Image("background2")
                .resizable()
                .background(.blue)
                .blur(radius: 30)
                .ignoresSafeArea()
            VStack{
                Text("\(modelData.userLocation)").font(.largeTitle)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
            }
            
            .onAppear {
                Task.init {
                    self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                   
                }
                
        }              
        }
        .preferredColorScheme(.dark)
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
