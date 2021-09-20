//
//  CityManager.swift
//  WeatherAPI-Testing
//
//  Created by Lucas Frazão on 19/09/21.
//

import Foundation

protocol CityManagerDelegate {
    func didUpdateCityManager(city: CityModel)
}

class CityManager {
    
    var delegate: CityManagerDelegate?
    
    func performRequest(with cityName: String) {
        
        let url = URL(string: "https://countriesnow.space/api/v0.1/countries/population/cities")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "city": cityName,
        ]
        request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                      print("error", error ?? "Unknown error")
                      return
                  }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            //let responseString = String(data: data, encoding: .utf8)
            
            if let city = self.parseJSON(with: data) {
                
                self.delegate?.didUpdateCityManager(city: city)
                
            }
            
        }
        
        task.resume()
        
        
    }
    
    private func parseJSON(with cityData: Data) -> CityModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decoderData = try decoder.decode(CityRequest.self, from: cityData)
            let city = decoderData.data.city
            let country = decoderData.data.country
            
            let information = CityModel(city: city, country: country)
            
            return information
            
        } catch {
            //delegate?.didFailWithError()
            print(error)
            return nil
        }
        
    }
    
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
