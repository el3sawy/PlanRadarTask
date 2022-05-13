//
//  ListCitiesViewControllerViewController.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import UIKit

class ListCitiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
