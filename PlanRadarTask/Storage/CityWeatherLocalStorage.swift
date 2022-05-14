//
//  CittyLocalStorage.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import Foundation

protocol CityWeatherLocalStorageProtocol {
    func addCityWeather(with city: CityUIModel)
    func deleteCity(with index: Int)
    func fetchCitiesNames() -> [String]
    func fetchCityDetails(at index: Int) -> [CityUIModel]
}

class CityWeatherLocalStorage {
    
    // MARK: - Properties
    private let localStorage = CoreDataStack.shared
    private var cities: [CityModel] = []
    
    init() {
        loadCities()
    }
    // MARK: - Functions
    private func getCityIndex(name: String) -> Int? {
        return cities.firstIndex(where: {$0.name == name})
    }
    
    private func loadCities() {
        do {
        cities = try localStorage.viewContext.fetch(CityModel.fetchRequest())
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - Extension
extension CityWeatherLocalStorage: CityWeatherLocalStorageProtocol {
    func addCityWeather(with city: CityUIModel) {
        if let index =  getCityIndex(name: city.name) {
            // Old City
            addWeather(city, index: index)
        } else {
            // New City
            addNewCity(city)
        }
    }
    
    private func addNewCity(_ model: CityUIModel) {
        let city = CityModel(context: localStorage.viewContext)
        city.name = model.name
        let weather = getWeatherModel(model)
        weather.city = city
        localStorage.saveContext()
        
        cities.append(city)
    }
    
    private func addWeather(_ model: CityUIModel, index: Int) {
        let city = cities[index]
        let weather = getWeatherModel(model)
        weather.city = city
        localStorage.saveContext()
//        cities.append(city)
        
        print(cities.count)
    }
    
    private func getWeatherModel(_ model: CityUIModel) -> WeatherInfoModel {
        let weather = WeatherInfoModel(context: localStorage.viewContext)
        weather.humidity = model.humidity
        weather.imageURL = model.imageURL
        weather.wind =  model.wind
        weather.temperature = model.temperature
        weather.descriptionInfo = model.description
        weather.timeTemp = Date()
        return weather
    }
    
    func deleteCity(with index: Int) {
        let city = cities[index]
        localStorage.viewContext.delete(city)
        localStorage.saveContext()
    }
    
    func fetchCitiesNames() -> [String] {
        cities.map({ $0.name })
    }
    
    func fetchCityDetails(at index: Int) -> [CityUIModel] {
        loadCities()
        let city = cities[index]
        let weathers = city.weathers
        let models: [CityUIModel] = weathers.map({
            CityUIModel(name: city.name, description: $0.descriptionInfo, humidity: $0.humidity, wind: $0.wind, temperature: $0.temperature, imageURL: $0.imageURL, timeTemp: $0.timeTemp)
            
        })
        let orderModel = models.sorted { a, b in
            a.timeTemp!  > b.timeTemp!
        }
        return orderModel
    }
}
