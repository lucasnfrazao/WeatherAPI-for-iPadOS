//
//  ViewController.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import UIKit

class ViewController: UIViewController {

    var weatherView = WeatherView()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        weatherManager.fetchWeather(with: "London")
    }
    
    override func loadView() {
        view = weatherView
    }
    

}

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeatherData(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.weatherView.temperatureDisplay.text = "\(weather.temperatureString)ºC"
            self.weatherView.cityName.text = weather.cityName
            self.weatherView.temperatureStatus.image = UIImage(systemName: weather.conditionName)
            self.weatherView.maxTemperature.text = "\(weather.maxTemperatureString)ºC"
            self.weatherView.minTemperature.text = "\(weather.minTemperatureString)ºC"
        }
        
    }
    
    func didFailWithError() {
        print("This operation could not be processed.")
    }
    
    
    
    
}
