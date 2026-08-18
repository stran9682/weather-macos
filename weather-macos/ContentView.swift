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
    @State private var path = NavigationPath()
    
    let timer = Timer.publish(every: 3600, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack(path: $path) {
            HStack {
                NavigationLink(value: Route.weatherDetail, label: {
                    let temperature = locationManger.forecast?.periods.first?.temperature
                    
                    WeatherWidget(temperature: temperature)
                        .onReceive(timer, perform: {_ in
                            locationManger.checkLocationAuthorization()
                        })
                })
                .buttonStyle(.plain)
                
                NavigationLink(value: Route.weatherDetail, label: {
                    ClockWidget()
                })
                .buttonStyle(.plain)
                
            }
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .weatherDetail:
                    WeatherView(locationManager: locationManger)
                }
            })
        }
    }
}

enum Route: Hashable {
    case weatherDetail
}

#Preview {
    ContentView()
        .frame(width: 600, height: 400)
}
