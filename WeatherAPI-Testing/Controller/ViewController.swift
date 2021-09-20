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
    
    var cityManager = CityManager()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    let searchController = UISearchController()
    
    var currentLocation = CLLocation()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        weatherManager.delegate = self
        cityManager.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a City"
        navigationItem.searchController = searchController
        navigationItem.title = "WeatherAPI"
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
        
        weatherManager.fetchWeather(with: "Paris")
        //cityManager.performRequest(with: "Rio de Janeiro")
        
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
        
        cityManager.performRequest(with: "Paris")
        
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

//MARK: - CityManagerDelegate

extension ViewController: CityManagerDelegate {
    
    func didUpdateCityManager(city: CityModel) {
        
        DispatchQueue.main.async {
            self.weatherView.countryName.text = city.country
        }
        
    }
    
}


//MARK: - UISearchControllerDelegate

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
