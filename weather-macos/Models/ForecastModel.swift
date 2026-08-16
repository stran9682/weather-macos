//
//  ForecastModel.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/15/26.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Forecast: Decodable {
    
    let generatedAt: Date
    let periods: [Period]
    
    enum PropertyKeys: String, CodingKey {
        case generatedAt
        case periods
    }
    
    enum CodingKeys: String, CodingKey {
        case properties
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let properties_container = try container.nestedContainer(keyedBy: PropertyKeys.self, forKey: .properties)
        generatedAt = try properties_container.decode(Date.self, forKey: .generatedAt)
        periods = try properties_container.decode([Period].self, forKey: .periods)
    }
}

// MARK: - Period
struct Period: Decodable, Identifiable {
    let id: Int
    let name: String
    let startTime: Date
    let temperature: Int
    let probabilityOfPrecipitation: Int?
    let windSpeed: String
    let windDirection: String
    let shortForecast: String
    
    enum CodingKeys: String, CodingKey {
        case id = "number"
        case name
        case startTime
        case temperature
        case probabilityOfPrecipitation
        case windSpeed
        case windDirection
        case shortForecast
    }
    
    enum ProbabilityKey: String, CodingKey {
        case value
    }
    
    struct Precipitation: Decodable {
        let value: Int?
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        startTime = try container.decode(Date.self, forKey: .startTime)
        temperature = try container.decode(Int.self, forKey: .temperature)
        windSpeed = try container.decode(String.self, forKey: .windSpeed)
        windDirection = try container.decode(String.self, forKey: .windDirection)
        shortForecast = try container.decode(String.self, forKey: .shortForecast)
        
        let precipitation = try container.decodeIfPresent(
           Precipitation.self,
           forKey: .probabilityOfPrecipitation
       )

       probabilityOfPrecipitation = precipitation?.value
    }
}


