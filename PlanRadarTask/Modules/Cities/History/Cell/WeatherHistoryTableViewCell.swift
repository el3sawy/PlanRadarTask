//
//  WeatherHistoryTableViewCell.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import UIKit

class WeatherHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let name = "WeatherHistoryTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var item: CityUIModel! {
        didSet {
            dateLabel.text = item.dateString
            weatherLable.text = item.description
        }
    }
}
