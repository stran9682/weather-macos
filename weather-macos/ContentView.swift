//
//  ContentView.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/15/26.
//

import SwiftUI
import Combine


struct ContentView: View {
    @State private var locationManger = LocationManager()
    
    let timer = Timer.publish(every: 3600, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination:
                WeatherView(locationManager: locationManger)
            ) {
                let temperature = locationManger.forecast?.periods.first?.temperature
                
                WeatherWidget(temperature: temperature)
                    .onReceive(timer, perform: {_ in 
                        locationManger.checkLocationAuthorization()
                    })
            }
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct WeatherWidget: View {
    
    var temperature: Int?
    
    var body: some View {
        if let temperature {
            let formated = Measurement(value: Double(temperature), unit: UnitTemperature.fahrenheit).formatted()
            
            Text("\(formated)")
                    .font(.custom("New York", size: 50, relativeTo: .body))
                .frame(width: 150, height: 150)
                .background(Color.orange.opacity(Double(temperature) / 100.0))
        } else {
            Text("Unknown")
                .frame(width: 150, height: 150)
                .background(.gray)
        }
    }
}


#Preview {
    ContentView()
        .frame(width: 600, height: 400)
}
