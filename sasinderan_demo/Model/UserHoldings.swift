//
//  UserHoldings.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 23/12/25.
//

import Foundation

struct UserHoldings: Codable {
    var userHolding: [IndividualHolding]?
    
    init(userHolding: [IndividualHolding]? = nil) {
        self.userHolding = userHolding
    }
    
    func getTotalInvestmentConsolidate() -> InvestmentConsolidate {
        let totalLossAndProfit = getCurrentValue() - getInitialInvestment()
        return InvestmentConsolidate(currentValue: getCurrentValue(), totalInvestment: getInitialInvestment(), todayPnL: getTodayProfitAndLoss(), totalPnL: totalLossAndProfit)
    }
    
    func getInitialInvestment() -> Double {
        if let allHoldings = self.userHolding {
            let value = allHoldings.map { Double($0.quantity.zeroUnWrapped) * $0.avgPrice.zeroUnWrapped }
            return value.reduce(0, +)
        } else {
            return -1
        }
    }
    
    func getCurrentValue() -> Double {
        if let allHoldings = self.userHolding {
            let value = allHoldings.map { Double($0.quantity.zeroUnWrapped) * $0.ltp.zeroUnWrapped }
            return value.reduce(0, +)
        } else {
            return -1
        }
    }
    
    func getTodayProfitAndLoss() -> Double {
        if let allHoldings = self.userHolding {
            let value = allHoldings.map { Double($0.quantity.zeroUnWrapped) * ($0.close.zeroUnWrapped - $0.ltp.zeroUnWrapped) }
            return value.reduce(0, +)
        } else {
            return -1
        }
    }
}
