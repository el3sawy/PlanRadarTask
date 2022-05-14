//
//  ListCitiesViewControllerViewController.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ListCitiesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ListCitiesTableViewCell.name, bundle: nil), forCellReuseIdentifier: ListCitiesTableViewCell.name)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
        }
    }
    
    // MARK: - Properties
    var viewModel: CitiesListViewModelProtocol = CitiesListViewModel(repository: CitiesRepository())
    private let disposeBag = DisposeBag()
    private var cities: [CityUIModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cities"
        addNavigationBarButtonItem()
        subscribeOnEvents()
    }
    
    // MARK: - Functions
    private func subscribeOnEvents() {
        viewModel.citiesObservable.subscribe(onNext: { [weak self] values in
            self?.cities = values
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
   private func addNavigationBarButtonItem() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(showAddCityAlertController))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc private func showAddCityAlertController() {
        let alertController = UIAlertController(title: "Add City", message: "Please add your favorite city", preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = "Enter City Name"
            textField.rx.text.orEmpty.asDriver().drive(self.viewModel.cityName).disposed(by: self.disposeBag)
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            self?.viewModel.fetchCityWeatherDetails()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource Methods
extension ListCitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCitiesTableViewCell.name, for: indexPath) as! ListCitiesTableViewCell
        cell.delegate = self
        cell.item = cities[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate Methods
extension ListCitiesViewController: UITableViewDelegate, ListCitiesTableViewCellProtocol {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = cities[indexPath.row]
        navigationController?.pushViewController(CityDetailsViewControllerViewController(model: model), animated: true)
    }
    
    func didTappedCityInfo(with city: String) {
        
    }
}
