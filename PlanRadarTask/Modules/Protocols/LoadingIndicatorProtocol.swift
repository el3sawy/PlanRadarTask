//
//  LoadingIndicatorProtocol.swift
//  PlanRadarTask
//
//  Created by Ahmed Elesawy on 13/05/2022.
//

import Foundation

protocol LoadingIndicatorProtocol {
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

extension LoadingIndicatorProtocol {
    func showLoadingIndicator() {
        SVProgressHUD.show()
    }
    
    func hideLoadingIndicator() {
        SVProgressHUD.dismiss()
    }
}
