//
//  WeatherRouter.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import Foundation

protocol WeatherRouterProtocol: Router {
    func pushWeatherDetails(weather: CityUIModel)
    func pushWeatherHistory(weathers: [CityUIModel])
}

class WeatherRouter: WeatherRouterProtocol {
    var sourceViewController: UIViewController?
    
    func pushWeatherDetails(weather: CityUIModel) {
        let viewController = WeatherConfigurator.weatherDetails(weather: weather)
        pushViewController(viewController)
    }
    
    func pushWeatherHistory(weathers: [CityUIModel]) {
        let viewController = WeatherConfigurator.weatherHistory(weathers: weathers)
        pushViewController(viewController)
    }
}
