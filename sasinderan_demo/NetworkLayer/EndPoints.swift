//
//  EndPoints.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation


enum EndPoints {
    case getPortfolioHoldings
}


extension EndPoints {
    var url : URL? {
        switch self {
        case .getPortfolioHoldings:
            return URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/")
        }
    }
}
