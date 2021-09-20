//
//  CityData.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import Foundation

struct CityRequest: Codable {
    
    let data: CityData
    
}

struct CityData: Codable {
    
    let city: String
    let country: String
}
