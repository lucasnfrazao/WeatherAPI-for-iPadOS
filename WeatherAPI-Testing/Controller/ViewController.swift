//
//  ViewController.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var weatherView = WeatherView()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        weatherManager.delegate = self
        weatherManager.fetchWeather(with: "London")
        
        weatherView.locationButton.addTarget(self, action: #selector(fetchUserLocation), for: .touchUpInside)
    }
    
    override func loadView() {
        view = weatherView
    }
    
    @objc func fetchUserLocation(_ sender: UIButton) {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    

}

//MARK: - WeatherManagerDelegate

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

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(lat: lat, lon: lon)
            currentLocation = location
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .default)
            let image = UIImage(systemName: "location.fill", withConfiguration: largeConfig)
            weatherView.locationButton.setImage(image, for: .normal)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let alert = UIAlertController(title: "Couldn't find location", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(action)
        
        self.present(alert, animated: true)
        
        print(error)
    }
    
}
