//
//  WeatherData.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    
}

struct Weather: Codable {
    
    let id: Int
    let main: String
    let description: String
    
}
