//
//  WeatherView.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import UIKit

class WeatherView: UIView {

    var temperatureDisplay: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        label.textColor = .label
        label.text = "32ºC"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        label.textColor = .label
        label.text = "Searching..."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var temperatureStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var stackViewMaxTemperature: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    
    var maxTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        label.text = "Updating..."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var maxTemperatureIndicator: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .label
        label.text = "Max Temp."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var stackViewMinTemperature: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        return stackView
    }()
    
    var minTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        label.text = "Updating..."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var minTemperatureIndicator: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .label
        label.text = "Min Temp."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupHierarchy()
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHierarchy()
        setupSubviews()
        setupConstraints()
    }
    
    func setupHierarchy() {
        self.addSubview(temperatureDisplay)
        self.addSubview(cityName)
        self.addSubview(temperatureStatus)
        self.addSubview(stackViewMaxTemperature)
        self.addSubview(stackViewMinTemperature)
        stackViewMaxTemperature.addArrangedSubview(maxTemperature)
        stackViewMaxTemperature.addArrangedSubview(maxTemperatureIndicator)
        stackViewMinTemperature.addArrangedSubview(minTemperature)
        stackViewMinTemperature.addArrangedSubview(minTemperatureIndicator)
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            temperatureStatus.widthAnchor.constraint(equalTo: temperatureDisplay.widthAnchor),
            temperatureStatus.heightAnchor.constraint(equalTo: temperatureStatus.widthAnchor),
            temperatureStatus.centerXAnchor.constraint(equalTo: temperatureDisplay.centerXAnchor),
            temperatureStatus.bottomAnchor.constraint(equalTo: temperatureDisplay.topAnchor),
            temperatureDisplay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureDisplay.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityName.topAnchor.constraint(equalTo: temperatureDisplay.bottomAnchor),
            cityName.centerXAnchor.constraint(equalTo: temperatureDisplay.centerXAnchor),
            stackViewMaxTemperature.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackViewMaxTemperature.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackViewMinTemperature.centerYAnchor.constraint(equalTo: stackViewMaxTemperature.centerYAnchor),
            stackViewMinTemperature.leadingAnchor.constraint(equalTo: stackViewMaxTemperature.layoutMarginsGuide.trailingAnchor, constant: 20)
        ])
        
        
        
    }
    

}
