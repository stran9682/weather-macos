//
//  WeatherStationModels.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/15/26.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherStation = try? JSONDecoder().decode(WeatherStation.self, from: jsonData)

import Foundation

// MARK: - WeatherStation
struct WeatherStation: Decodable {
    let id: String
    let properties: WeatherStationProperties
}

// MARK: - WeatherStationProperties
struct WeatherStationProperties: Decodable {
    let forecast: String
    let forecastHourly: String
    let forecastGridData: String
    let relativeLocation: RelativeLocation
    let astronomicalData: AstronomicalData
}

// MARK: - AstronomicalData
struct AstronomicalData: Decodable {
    let sunrise: Date
    let sunset: Date
    let transit: Date
    let astronomicalTwilightBegin: Date
    let astronomicalTwilightEnd: Date
}

// MARK: - RelativeLocation
struct RelativeLocation: Decodable {
    let properties: RelativeLocationProperties
}

// MARK: - RelativeLocationProperties
struct RelativeLocationProperties: Decodable {
    let city: String
    let state: String
}

