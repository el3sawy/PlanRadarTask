//
//  ListCitiesTableViewCell.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import UIKit
protocol ListCitiesTableViewCellProtocol: AnyObject {
    
}

class ListCitiesTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: ListCitiesTableViewCellProtocol?
    static let name = "ListCitiesTableViewCell"
    
    // MARK: - Methods
    func configure(with title: String?) {
        titleLabel.text = title
    }
    
    // MARK: - Button Actions
    @IBAction func infoTapped(_ sender: Any) {
    }
    
}
