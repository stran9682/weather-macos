//
//  LocationManager.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/15/26.
//

import CoreLocation
import SwiftUI

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var location: CLLocationCoordinate2D?
    var forecast: Forecast?
    var placemark: CLPlacemark?
    
    private let manager = CLLocationManager()
    
    override init () {
        super.init()
        manager.delegate = self
    }
    
    func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case.authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
    
    private func coordinatesToPlace(coordinates: CLLocation?) async {
        let geocoder = CLGeocoder()
        
        if let coordinates {
            let placemarks = try? await geocoder.reverseGeocodeLocation(coordinates)
            
            self.placemark = placemarks?.first
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)  {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first?.coordinate
        
        if let location = self.location {
            Task {
                guard let weatherStation = try? await getWeatherStation(location: location) else { return }
                
                self.forecast = try? await getForecast(weatherStation: weatherStation.properties.forecastHourly)
                
                await coordinatesToPlace(coordinates: locations.first)
            }
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location = nil
    }
}

func getForecast(weatherStation: String) async throws -> Forecast?  {
    guard let url = URL(string: weatherStation) else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    let weather = try? decoder.decode(Forecast.self, from: data)
    
    return weather
}

func getWeatherStation(location: CLLocationCoordinate2D) async throws -> WeatherStation? {
    let latitude = Double(round(10_000 * location.latitude) / 10_000)
    let longitude = Double(round(10_000 * location.longitude) / 10_000)
    
    guard let url = URL(string: "https://api.weather.gov/points/\(latitude),\(longitude)") else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    let weatherstation = try? decoder.decode(WeatherStation.self, from: data)
    
    return weatherstation
}
