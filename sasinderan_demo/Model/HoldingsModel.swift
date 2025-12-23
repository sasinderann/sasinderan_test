//
//  HoldingsModel.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation

struct HoldingsModel: Codable {
    var data: UserHoldings?
}

struct UserHoldings: Codable {
    var userHolding: [IndividualHolding]?
}

struct IndividualHolding: Codable {
    var symbol: String?
    var quantity: Int?
    var ltp: Double?
    var avgPrice: Double?
    var close: Double?
    
    func getCurrentValue() -> Double {
        if let quantity = self.quantity, let lastTradePrice = self.ltp, let avgPrice = self.avgPrice {
            let currentValue = lastTradePrice * Double(quantity)
            let invested = avgPrice * Double(quantity)
            return currentValue - invested
        }
        return -1
    }
}
