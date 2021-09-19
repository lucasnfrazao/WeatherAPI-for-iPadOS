//
//  WeatherModel.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import Foundation

struct WeatherModel {
    
    let conditionID: Int
    let cityName: String
    let temperature: Double

    let minTemperature: Double
    let maxTemperature: Double
    
    let lat: Double?
    let lon: Double?
    
    var temperatureString: String {
        return String(format: "%0.0f", temperature)
    }
    
    var minTemperatureString: String {
        return String(format: "%0.0f", minTemperature)
    }
    
    var maxTemperatureString: String {
        return String(format: "%0.0f", maxTemperature)
    }
    
    var conditionName: String {
        
        switch conditionID {
            
        case 200...232:
            return "cloud.bolt"
        default:
            return "sun.max"
            
        }
        
    }
    
}
