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
    var cache : HoldingsCacheProtocol
    
    init(APIClient: APIClient, cache: HoldingsCacheProtocol) {
        self.APIClient = APIClient
        self.cache = cache
    }
    
    func getUserPortFolioData(completion: @escaping (Result<HoldingsModel, Error>) -> Void) {
        
        if let cached = cache.loadCache() { // if cache available
            completion(.success(cached))
        }
        self.APIClient.executeRequest(endpoint: .getPortfolioHoldings) { (result: Result<HoldingsModel, Error>) in
            switch result {
            case .success(let holdings):
                self.cache.saveCache(holdings: holdings)
            case .failure(let error):
                print(error)
            }
            completion(result)
        }
    }
}
