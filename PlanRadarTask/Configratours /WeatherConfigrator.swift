//
//  WeatherConfigrator.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import Foundation

class WeatherConfigurator {
    
    static func listCities() -> UIViewController {
        let repository = CitiesRepository()
        let localStorage = CityWeatherLocalStorage()
        let viewController = ListCitiesViewController()
        let router = WeatherRouter()
        router.sourceViewController = viewController
        let viewModel = CitiesListViewModel(repository: repository, cityLocalStorage: localStorage, router: router)
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func weatherDetails(weather: CityUIModel) -> UIViewController {
        CityDetailsViewController(model: weather)
    }
    
    static func weatherHistory(weathers: [CityUIModel]) -> UIViewController {
         WeatherHistoryViewController(weathers: weathers)
    }
}
