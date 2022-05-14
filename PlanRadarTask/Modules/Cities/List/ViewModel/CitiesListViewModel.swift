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
    var citiesObservable: Observable<[CityUIModel]> { get }
    func fetchCityWeatherDetails()
}

class CitiesListViewModel {
    
    // MARK: - Properties
    private let repository: CitiesRepositoryProtocol
    private var cityNameRelay = BehaviorRelay<String>(value: "")
    private let errorPublishSubject = PublishSubject<Error>()
    private var cities = BehaviorRelay(value:[CityUIModel]())
    
    // MARK: - Init
    init(repository: CitiesRepositoryProtocol) {
        self.repository = repository
    }
}

extension CitiesListViewModel: CitiesListViewModelProtocol {
    
    var cityName: BehaviorRelay<String> {
        set { cityNameRelay.accept(newValue.value) }
        get { return cityNameRelay }
    }
    
    var citiesObservable: Observable<[CityUIModel]> {
        return cities.asObservable()
    }
    
    func fetchCityWeatherDetails() {
        showLoadingIndicator()
        repository.fetchCityWeather(with: cityNameRelay.value) { [weak self] response, error in
            guard let self = self else { return }
            self.hideLoadingIndicator()
            
            if let returnedError = error {
                self.errorPublishSubject.onNext(returnedError)
            } else {
                let city = CityUIModel(name: self.cityNameRelay.value, description: response?.weather?.first?.description, humidity: "\(response?.main?.humidity ?? 0)", wind: "\(response?.wind?.speed ?? 0)", temperature: "\(response?.main?.temprature ?? 0.0)", imageURL: CitiesRequest.weatherIcon(iconId: response?.weather?.first?.icon ?? "").path, timeZone: response?.timezone)
                print(city)
                self.cities.accept(self.cities.value + [city])
            }
        }
    }
}
