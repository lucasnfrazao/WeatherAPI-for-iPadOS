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
        label.adjustsFontSizeToFitWidth = true
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
    
    var countryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        label.textColor = .label
        label.text = "Where's it?"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var temperatureStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var stackViewMaxTemperature: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.backgroundColor = .secondarySystemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.layer.cornerRadius = 10
        
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
        label.text = "Max. Temp."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var stackViewMinTemperature: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.backgroundColor = .secondarySystemBackground
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.layer.cornerRadius = 10
        
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
        label.text = "Min. Temp."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .default)
        let image = UIImage(systemName: "location", withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        button.backgroundColor = .tertiarySystemBackground
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 15
        
        return button
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
        self.addSubview(countryName)
        self.addSubview(locationButton)
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
            temperatureStatus.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            temperatureStatus.bottomAnchor.constraint(equalTo: temperatureDisplay.topAnchor),
            temperatureDisplay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cityName.topAnchor.constraint(equalTo: temperatureDisplay.bottomAnchor),
            cityName.centerXAnchor.constraint(equalTo: temperatureDisplay.centerXAnchor),
            countryName.topAnchor.constraint(equalTo: cityName.bottomAnchor),
            countryName.centerXAnchor.constraint(equalTo: cityName.centerXAnchor),
            locationButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20),
            locationButton.heightAnchor.constraint(equalTo: cityName.heightAnchor),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor),
            locationButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -20),
            stackViewMaxTemperature.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackViewMaxTemperature.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20),
            stackViewMinTemperature.centerXAnchor.constraint(equalTo: stackViewMaxTemperature.centerXAnchor),
            stackViewMinTemperature.topAnchor.constraint(equalTo: stackViewMaxTemperature.layoutMarginsGuide.bottomAnchor, constant: 35)
        ])
     
    }
    

}
