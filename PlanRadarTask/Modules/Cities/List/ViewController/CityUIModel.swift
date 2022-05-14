//
//  CityUIModel.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import Foundation

struct CityUIModel {
    
    // MARK: - Properties
    var name: String?
    var description: String?
    var humidity: String?
    var wind: String?
    var temperature: String?
    var imageURL: String?
    var timeZone: Int?
    
    private var time: String {
        let zone = String(timeZone ?? 0)
        return localTime(in: zone)
    }
    
    var largeDescription: String {
        return "Weather information for \(name ?? "") received on \(time)"
    }
    
    private func localTime(in timeZone: String) -> String {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        f.timeZone = TimeZone(identifier: timeZone)
        return f.string(from: Date())
    }
}
