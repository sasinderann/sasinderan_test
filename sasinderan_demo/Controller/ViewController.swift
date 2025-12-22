//
//  ViewController.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkResponse()
    }
    
    func checkResponse() {
        let apiClient = APIClient()
        let service = PortFolioRequestService(APIClient: apiClient)
        let viewModel = PortfolioPageViewModel(APIService: service)
        viewModel.fetchUserHoldings()
    }
}

