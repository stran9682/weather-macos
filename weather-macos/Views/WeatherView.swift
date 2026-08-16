//
//  WeatherView.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/16/26.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    var locationManager: LocationManager
    
    var body: some View {
        VStack {
            HStack {
                
                let placemark = (locationManager.placemark != nil) ?
                locationManager.placemark!.locality! + ", " + locationManager.placemark!.administrativeArea!
                : "Unknown"
                
                Text("\(placemark)")
                    .font(.largeTitle)
                
                Button(action: {
                    locationManager.checkLocationAuthorization()
                }) {
                    Image(systemName: "mappin.and.ellipse.circle.fill")
                }
            }
            
            if let periods = locationManager.forecast?.periods {
                ScrollView(.horizontal, content: {
                    HStack {
                        ForEach(periods, content: { period in
                            WeatherWidget(temperature: period.temperature)
                        })
                    }
                })
            }
        }
    }
}

#Preview {
    WeatherView(locationManager: LocationManager())
        .frame(width: 400, height: 500)
}
