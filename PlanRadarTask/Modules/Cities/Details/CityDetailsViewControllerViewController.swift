//
//  CityDetailsViewControllerViewController.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import UIKit
import Kingfisher

class CityDetailsViewControllerViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    
    // MARK: - Proporties
    private var model: CityUIModel
    
    // MARK: -  Life Cycle
    init(model: CityUIModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
    }
    
    // MARK: - Functions
    private func setValues() {
        title = model.name
        descriptionTitleLabel.text = model.largeDescription
        descriptionLabel.text = model.description
        temperatureLabel.text = model.temperature
        humidityLabel.text = model.humidity
        windSpeedLabel.text = model.wind
        weatherIconImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
    }
}
