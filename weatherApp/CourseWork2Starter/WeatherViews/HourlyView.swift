//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
   @EnvironmentObject var modelData: ModelData

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .background(.blue)
                .blur(radius: 30)
                .ignoresSafeArea()

            VStack{
                Text("\(modelData.userLocation)")
                    .font(.largeTitle)
                    .foregroundColor(Color(hue: 0.548, saturation: 0.98, brightness: 0.229).opacity(1))
                    List {
                        ForEach(modelData.forecast!.hourly) { hour in
                            HourCondition(current: hour)
                        }
                    }
                    .scrollContentBackground(.hidden)
                Spacer()
            }
    
        }
        

    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
