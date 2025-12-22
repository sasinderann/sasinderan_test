//
//  PortfolioPageViewModel.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation

final class PortfolioPageViewModel {
    
    private var userHoldings: [IndividualHolding] = []
    
    private var apiService: PortFolioRequestServiceProtocol
    
    init(APIService: PortFolioRequestServiceProtocol) {
        self.apiService = APIService
    }
    
    func fetchUserHoldings() {
        apiService.getUserPortFolioData() { [weak self] holdingResponse in
            DispatchQueue.main.async {
                switch holdingResponse {
                case .success(let holdings):
                    print(holdings)
                    if let userHoldings = holdings.data?.userHolding {
                        self?.userHoldings = userHoldings
                    }
                case .failure(let error):
                    print("==== Error in Fetching user Holdings: \(error)")
                }
            }
            
        }
    }
}
