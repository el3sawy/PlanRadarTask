//
//  WeatherHistoryViewController.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import UIKit

class WeatherHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: WeatherHistoryTableViewCell.name, bundle: nil), forCellReuseIdentifier: WeatherHistoryTableViewCell.name)
            tableView.rowHeight = 80
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private var weathers: [CityUIModel] = []
    
    init(weathers: [CityUIModel]) {
        self.weathers = weathers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = weathers.first?.name
    }

}

extension WeatherHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHistoryTableViewCell.name) as! WeatherHistoryTableViewCell
        cell.item = weathers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = weathers[indexPath.row]
        let viewController = CityDetailsViewController(model: model)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
