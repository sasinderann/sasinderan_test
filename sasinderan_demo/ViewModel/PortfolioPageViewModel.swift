//
//  PortfolioPageViewModel.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation

protocol PortfolioPageDelegate: AnyObject {
    func reloadData()
}

final class PortfolioPageViewModel {
    
    var userHoldings: [IndividualHolding] = []
    
    var apiService: PortFolioRequestServiceProtocol
    var delegate: PortfolioPageDelegate?
    
    init(APIService: PortFolioRequestServiceProtocol) {
        self.apiService = APIService
    }
    
    func fetchUserHoldings() {
        apiService.getUserPortFolioData() { [weak self] holdingResponse in
            DispatchQueue.main.async {
                switch holdingResponse {
                case .success(let holdings):
                    if let userHoldings = holdings.data?.userHolding {
                        self?.userHoldings = userHoldings
                        self?.delegate?.reloadData()
                    }
                case .failure(let error):
                    print("==== Error in Fetching user Holdings: \(error)")
                }
            }
            
        }
    }
}
