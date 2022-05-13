//
//  ListCitiesViewControllerViewController.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import UIKit

class ListCitiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ListCitiesTableViewCell.name, bundle: nil), forCellReuseIdentifier: ListCitiesTableViewCell.name)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cities"
        addNavigationBarButtonItem()
    }
    
    // MARK: - Functions
    func addNavigationBarButtonItem() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(showAddCityAlertController))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
   @objc func showAddCityAlertController() {
        let alertController = UIAlertController(title: "Add City", message: "Please add your favorite city", preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            
            textField.placeholder = "Enter City Name"
            
            
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCitiesTableViewCell.name, for: indexPath) as! ListCitiesTableViewCell
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate Methods
extension ListCitiesViewController: UITableViewDelegate, ListCitiesTableViewCellProtocol {
    
}




