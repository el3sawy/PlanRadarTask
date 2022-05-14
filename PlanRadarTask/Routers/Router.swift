//
//  Router.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 14/05/2022.
//

import Foundation

protocol PresentableAlert {
    var sourceViewController: UIViewController? {get set}
    func showAlert(title: String?, message: String)
}

extension PresentableAlert {
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        sourceViewController?.present(alert, animated: true, completion: nil)
    }
}

protocol Presentable {
    var sourceViewController: UIViewController? {get set}
    func pushViewController(_ viewController: UIViewController)
}
extension Presentable {
    func pushViewController(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        sourceViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
   
}
protocol Router: PresentableAlert, Presentable {}

