//
//  CityModel.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import CoreData

class CityDataModel: NSManagedObject, Identifiable {
    
    @NSManaged var name: String
    @NSManaged var weatherSet: NSSet
    
    var weathers: [WeatherDataModel] {
        weatherSet.map({ $0 as! WeatherDataModel })
    }
}
