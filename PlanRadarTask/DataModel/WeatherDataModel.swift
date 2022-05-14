//
//  WeatherDataModel.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import CoreData

class WeatherDataModel: NSManagedObject, Identifiable  {
    
    @NSManaged var name: String
    @NSManaged var descriptionInfo: String
    @NSManaged var humidity: String
    @NSManaged var imageURL: String
    @NSManaged var temperature: String
    @NSManaged var timeTemp: String
    @NSManaged var wind: String
    
    @NSManaged var city: CityDataModel
}
