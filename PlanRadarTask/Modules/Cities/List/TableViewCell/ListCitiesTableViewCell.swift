//
//  ListCitiesTableViewCell.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import UIKit
protocol ListCitiesTableViewCellProtocol: AnyObject {
    func didTappedCityInfo(cell: ListCitiesTableViewCell)
}

class ListCitiesTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: ListCitiesTableViewCellProtocol?
    static let name = "ListCitiesTableViewCell"
    
    // MARK: - Methods
    var item: String! {
        didSet {
            titleLabel.text = item
        }
    }
    
    // MARK: - Button Actions
    @IBAction func infoTapped(_ sender: Any) {
        delegate?.didTappedCityInfo(cell: self)
    }
    
}
