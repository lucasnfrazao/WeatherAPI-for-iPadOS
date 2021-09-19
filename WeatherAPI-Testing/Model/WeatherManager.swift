//
//  WeatherManager.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeatherData(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError()
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(APIManager.appID)&units=metric"
    
    func fetchWeather(with cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            // 3. Give it a task
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let data = data {
                    if let weather = self.parseJSON(with: data) {
                        self.delegate?.didUpdateWeatherData(self, weather: weather)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    private func parseJSON(with weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoderData.weather[0].id
            let name = decoderData.name
            let temperature = decoderData.main.temp
            let minTemparature = decoderData.main.temp_min
            let maxTemparature = decoderData.main.temp_max
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temperature, minTemperature: minTemparature, maxTemperature: maxTemparature)
            
            return weather
            
        } catch {
            delegate?.didFailWithError()
            print(error)
            return nil
        }
        
    }
    
}
