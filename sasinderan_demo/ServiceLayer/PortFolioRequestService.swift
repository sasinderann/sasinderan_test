//
//  PortFolioRequestService.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation

protocol PortFolioRequestServiceProtocol : AnyObject {
    func getUserPortFolioData(completion: @escaping (Result<HoldingsModel, Error>) -> Void)
}

final class PortFolioRequestService : PortFolioRequestServiceProtocol {
    
    var APIClient: APIClient
    
    init(APIClient: APIClient) {
        self.APIClient = APIClient
    }
    
    func getUserPortFolioData(completion: @escaping (Result<HoldingsModel, Error>) -> Void) {
        self.APIClient.executeRequest(endpoint: .getPortfolioHoldings, completion: completion)
    }
}
