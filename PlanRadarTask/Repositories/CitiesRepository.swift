//
//  CitiesRepository.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import Foundation

typealias APIResultHandler = (WeatherResponse?, Error?) -> Void

protocol CitiesRepositoryProtocol {
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler)
}

class CitiesRepository: CitiesRepositoryProtocol {
    
    // MARK: - Functions
    func fetchCityWeather(with city: String, completionHandler: @escaping APIResultHandler) {
        let apiClient = APIClient.sharedInstanceX() as! APIClient
        let request = CitiesRequest.details(city: city)
        apiClient.sendRequest(withURL: request.path, parameters: request.parameters, httpHeaders: request.httpHeaders, httpMethod: request.httpMethod.rawValue) { result, error in
            if error != nil {
                completionHandler(nil, error)
            } else {
                
                let weatherResponse = WeatherResponse(JSON: result as! [String: Any])
                completionHandler(weatherResponse, nil)
            }
        }
    }
    
}
