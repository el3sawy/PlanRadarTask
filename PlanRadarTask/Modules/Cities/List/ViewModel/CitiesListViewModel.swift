//
//  CitiesListViewModel.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol CitiesListViewModelProtocol: LoadingIndicatorProtocol {
    var cityName: BehaviorRelay<String> { set get }
    var citiesObservable: Observable<[String]> { get }
    func fetchCityWeatherDetails()
    func getWeatherInfo(at index: Int) -> CityUIModel
    func getWeatherInfoHistory(at index: Int) -> [CityUIModel]
    func deleteWeather(at index: Int)
    var router: WeatherRouterProtocol { get }
}

class CitiesListViewModel {
    
    // MARK: - Properties
    private let repository: CitiesRepositoryProtocol
    private let cityLocalStorage: CityWeatherLocalStorageProtocol
    private var cityNameRelay = BehaviorRelay<String>(value: "")
    private var cities = BehaviorRelay(value:[String]())
    var router: WeatherRouterProtocol
    
    // MARK: - Init
    init(repository: CitiesRepositoryProtocol,
         cityLocalStorage: CityWeatherLocalStorageProtocol,
         router: WeatherRouterProtocol) {
        self.repository = repository
        self.cityLocalStorage = cityLocalStorage
        self.router = router
        loadCitiesFromCash()
    }
    
    private func loadCitiesFromCash() {
        let data = cityLocalStorage.fetchCitiesNames()
        cities.accept(data)
    }
}

extension CitiesListViewModel: CitiesListViewModelProtocol {
    
    var cityName: BehaviorRelay<String> {
        set { cityNameRelay.accept(newValue.value) }
        get { return cityNameRelay }
    }
    
    var citiesObservable: Observable<[String]> {
        return cities.asObservable()
    }
    
    func fetchCityWeatherDetails() {
        showLoadingIndicator()
        repository.fetchCityWeather(with: cityNameRelay.value) { [weak self] response, error in
            guard let self = self else { return }
            self.hideLoadingIndicator()
            
            if let returnedError = error {
                self.router.showAlert(title: "Error", message: returnedError.localizedDescription)
            } else {
                let city = self.mapCityModel(response: response)
                self.cityLocalStorage.addCityWeather(with: city)
                self.cities.accept(self.cityLocalStorage.fetchCitiesNames())
            }
        }
    }
    
    private func mapCityModel(response: WeatherResponse?) -> CityUIModel {
        return CityUIModel(
            name: self.cityNameRelay.value,
            description: response?.weather?.first?.description   ?? "",
            humidity: "\(response?.main?.humidity ?? 0)",
            wind: "\(response?.wind?.speed ?? 0)",
            temperature: "\(response?.main?.temprature ?? 0.0)",
            imageURL: CitiesRequest.weatherIcon(iconId: response?.weather?.first?.icon ?? "").path)
    }
    
    func getWeatherInfo(at index: Int) -> CityUIModel {
        return cityLocalStorage.fetchCityDetails(at: index).first!
    }
    
    func getWeatherInfoHistory(at index: Int) -> [CityUIModel] {
        return cityLocalStorage.fetchCityDetails(at: index)
    }
    
    func deleteWeather(at index: Int) {
        cityLocalStorage.deleteCity(with: index)
        var data = self.cities.value
        data.remove(at: index)
        cities.accept(data)
    }
}
