//
//  CachingService.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 24/12/25.
//

import Foundation

protocol HoldingsCacheProtocol {
    func saveCache(holdings: HoldingsModel)
    func loadCache() -> HoldingsModel?
}

class UserdefaultCaching: HoldingsCacheProtocol {
    
    var defaults: UserDefaults
    var cacheKey: String = "user_holdings"
    
    init(defaults: UserDefaults, cacheKey: String) {
        self.defaults = defaults
        self.cacheKey = cacheKey
    }
    
    func saveCache(holdings: HoldingsModel) {
        do {
            let data = try JSONEncoder().encode(holdings)
            defaults.set(data, forKey: cacheKey)
        } catch {
            print("Cache save failed:", error)
        }
    }
    
    func loadCache() -> HoldingsModel? {
        guard let data = defaults.data(forKey: cacheKey) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(HoldingsModel.self, from: data)
        } catch {
            print("Cache load failed:", error)
            return nil
        }
    }
}
