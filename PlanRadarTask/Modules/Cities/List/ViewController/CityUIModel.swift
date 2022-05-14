//
//  CityUIModel.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import Foundation

struct CityUIModel {
    
    // MARK: - Properties
    var name: String
    var description: String
    var humidity: String
    var wind: String
    var temperature: String
    var imageURL: String
    var timeTemp: Date?

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: timeTemp ?? Date())
    }
}
